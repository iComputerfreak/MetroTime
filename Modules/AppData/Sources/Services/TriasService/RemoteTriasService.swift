// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import AppNetworking
import Foundation
import OSLog
import XMLCoder

// TODO: Implement
public final class RemoteTriasService: TriasService {
    private let client: Client
    
    public init() {
        client = Client(
            configuration: .init(
                // TODO: Store somewhere outside of git
                baseURLProvider: URL(string: "")!,
                interceptors: [LoggingInterceptor(logger: Logger.network)],
                encoder: XMLEncoder(),
                decoder: XMLDecoder(trimValueWhitespaces: true),
                cache: .init()
            )
        )
    }
    
    public func fetchStations(byName name: String) async throws -> [any StationProtocol] {
        let endpoint: Endpoint<TriasResponse<LocationInformationResponse>> = .init(pathComponent: "")
        let requestBody = APIRequestFactory.createLocationInformationRequest(for: name, requestorRef: "", allowedTypes: [.stop])
        let response = try await client.post(endpoint: endpoint, body: requestBody)
        return try LocationInformationResponseMapper.map(response)
    }
    
    public func fetchStation(byID id: String) async throws -> any StationProtocol {
        Station(id: "", name: "", localityID: "", locality: "", latitude: 0, longitude: 0, altitude: nil)
    }
    
    public func fetchDepartures(at station: any StationProtocol) async throws -> [any DepartureProtocol] {
        []
    }
    
    public func fetchDepartures(at stations: [any StationProtocol]) async throws -> [any DepartureProtocol] {
        []
    }
    
    public func fetchLines(at station: any StationProtocol) async throws -> [any LineProtocol] {
        []
    }
}
