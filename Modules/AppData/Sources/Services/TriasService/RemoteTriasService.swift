// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import AppNetworking
import Foundation
import JFUtils
import OSLog
import XMLCoder

// TODO: Implement
public final class RemoteTriasService: TriasService {
    private enum Constants {
        static let maxRequestsPerSecond: Int = 10
    }
    
    private static let encoder: AppNetworking.Encoder = {
        let encoder = TriasXMLEncoder(
            rootKey: "TriasRequest",
            rootAttributes: [
                "xmlns": "http://www.vdv.de/trias",
                "version": "1.2",
                "xmlns:siri": "http://www.siri.org.uk/siri"
            ]
        )
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    private static let decoder: AppNetworking.Decoder = {
        let decoder = TriasXMLDecoder(trimValueWhitespaces: true)
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private let client: Client
    
    public init() {
        client = Client(
            configuration: .init(
                // TODO: Store somewhere outside of git
                baseURLProvider: URL(string: "")!,
                interceptors: [
                    HeaderFieldsInterceptor(
                        addContentLength: true,
                        headerFields: [
                            "Content-Type": "application/xml",
                            "Accept": "*/*"
                        ]
                    ),
                    LoggingInterceptor(logger: Logger.network)
                ],
                encoder: Self.encoder,
                decoder: Self.decoder,
                cache: .init()
            )
        )
    }
    
    public func fetchStations(byName name: String) async throws -> [any StationProtocol] {
        let endpoint: Endpoint<TriasResponse<LocationInformationResponse>> = .init(pathComponent: "")
        // TODO: Keep out of git
        let requestBody = APIRequestFactory.createLocationInformationRequest(searchString: name, requestorRef: "", allowedTypes: [.stop])
        do {
            let response = try await client.post(endpoint: endpoint, body: requestBody)
            return try LocationInformationResponseMapper.map(response)
        } catch {
            Logger.network.error("Error fetching stations by name: \(error)")
            throw error
        }
    }
    
    public func fetchDepartures(at station: any StationProtocol, lines: [any LineProtocol]? = nil) async throws -> [any DepartureProtocol] {
        let endpoint: Endpoint<TriasResponse<StopEventResponse>> = .init(pathComponent: "")
        // TODO: Keep out of git
        let requestBody = APIRequestFactory.createStopEventRequest(for: station.id, includedLines: lines, requestorRef: "")
        do {
            let response = try await client.post(endpoint: endpoint, body: requestBody)
            return try StopEventResponseMapper.map(response)
        } catch {
            Logger.network.error("Error fetching departures at station: \(error)")
            throw error
        }
    }
    
    public func fetchDepartures(
        at stations: [any StationProtocol],
        lines: [String: [any LineProtocol]]? = nil
    ) async throws -> [String: [any DepartureProtocol]] {
        return try await withThrowingTaskGroup(
            of: (stationID: String, departures: [any DepartureProtocol]).self,
            returning: [String: [any DepartureProtocol]].self
        ) { [weak self] taskGroup in
            guard let self else { return [:] }
            
            // Add tasks
            for stationChunk in stations.chunked(into: Constants.maxRequestsPerSecond) {
                for station in stationChunk {
                    let addTaskResult = taskGroup.addTaskUnlessCancelled(priority: .userInitiated) {
                        let linesAtStation = lines?[station.id]
                        let departures = try await self.fetchDepartures(at: station, lines: linesAtStation)
                        return (station.id, departures)
                    }
                    // If we are cancelled, return
                    guard addTaskResult else {
                        return [:]
                    }
                }
                // Wait a second before starting the next chunk of requests
                try await Task.sleep(for: .seconds(1))
            }
            
            // Put all departures into a dictionary
            var departures: [String: [any DepartureProtocol]] = [:]
            for try await result in taskGroup {
                departures[result.stationID] = result.departures
            }
            
            return departures
        }
    }
    
    public func fetchLines(at station: any StationProtocol) async throws -> [any LineProtocol] {
        try await fetchDepartures(at: station)
            .removingDuplicates(key: \.lineID)
            .map { departure in
                Line(
                    id: departure.lineID,
                    name: departure.lineName,
                    directionID: departure.directionID,
                    direction: departure.direction
                )
            }
    }
}
