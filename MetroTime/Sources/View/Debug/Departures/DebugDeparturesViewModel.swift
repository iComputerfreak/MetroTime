// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation
import SwiftUI
import XMLCoder

class DebugDeparturesViewModel: ViewModelProtocol {
    enum State {
        case loading
        case loaded
        case error(Error)
    }
    
    let stopID: String
    @Published var state: State
    @Published var departures: [StopEventResult]
    
    init(stopID: String, state: State = .loading, departures: [StopEventResult] = []) {
        self.stopID = stopID
        self.state = state
        self.departures = departures
    }
    
    func fetchDepartures() async throws {
        guard let requestorRef = ProcessInfo.processInfo.environment["TRIAS_REQUESTOR_REF"] else {
            fatalError("NO REQUESTOR REF!")
        }
        
        var request = URLRequest(url: URL(string: "https://projekte.kvv-efa.de/freytrias/trias")!)
        request.httpMethod = "POST"
        request.setValue("text/xml", forHTTPHeaderField: "Content-Type")
        // TODO: Debug why encoding / decoding does not work.
        let requestBody = APIRequestFactory.createStopEventRequest(for: stopID, requestorRef: requestorRef)
        let encoder = XMLEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.prettyPrintIndentation = .spaces(2)
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try encoder.encode(requestBody, withRootKey: "Trias", rootAttributes: [
            "version": "1.2",
            "xmlns": "http://www.vdv.de/trias",
            "xmlns:siri": "http://www.siri.org.uk/siri"
        ])
        let bodyString = String(data: request.httpBody!, encoding: .utf8)!
        print("Sending API Request with Body:\n\(bodyString)")
        
        guard let response: TriasResponse<StopEventResponse> = try await decodeRequest(request) else {
            return
        }
        
        print(response)
        
        guard let results = response.serviceDelivery.payload.requestOrResponse.stopEventResults else {
            print("No results. Error message: \(response.serviceDelivery.payload.requestOrResponse.errorMessage?.text?.text ?? "nil")")
            return
        }
        
        departures = results
        state = .loaded
    }
    
    private func decodeRequest<T: Decodable>(_ request: URLRequest) async throws -> T? {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("Request failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
            return nil
        }
        guard !data.isEmpty else {
            print("No data received.")
            return nil
        }
        
        let decoder = XMLDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }
}
