// Copyright © 2024 Jonas Frey. All rights reserved.

import Combine
import JFSwiftUI
import SwiftUI
import XMLCoder

public struct ContentView: View {
    class ViewModel: ObservableObject {
        @Published var results: [String] = []
        @Published var searchText: String = ""
    }
    
    @State private var cancellable: AnyCancellable?
    @StateObject private var viewModel: ViewModel = .init()
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(Array(viewModel.results.enumerated()), id: \.offset) { _, result in
                    Text(result)
                }
                if viewModel.results.isEmpty {
                    Text("No results for term '\(viewModel.searchText)'.")
                }
            }
            .searchable(
                text: $viewModel.searchText,
                placement: .toolbar,
                prompt: Text("Search for a station")
            )
        }
        .onAppear {
            cancellable = viewModel.$searchText
                .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
                .removeDuplicates()
                .sink { text in
                    guard !text.isEmpty else {
                        self.viewModel.results = []
                        return
                    }
                    print("Searching for '\(text)'...")
                    Task {
                        do {
                            try await self.search(for: text)
                        } catch {
                            print("Error searching for '\(text)': \(error)")
                            print(error.localizedDescription)
                        }
                    }
                }
            viewModel.searchText = "Otto-Sachs"
        }
    }
    
    private func search(for query: String) async throws {
        let url = URL(string: "https://projekte.kvv-efa.de/freytrias/trias")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("text/xml", forHTTPHeaderField: "Content-Type")
        request.httpBody = try requestBody(for: query)
        
        let response = try await decodeRequest(request)
        let locations = response.locations?
            .filter { result in
                result.location.stopPoint != nil &&
                result.location.locationName.text.contains("Karlsruhe")
            }
            .sorted { result1, result2 in
                (result1.probability ?? 0) < (result2.probability ?? 0)
            }
            .compactMap { result in
                let location = result.location
                return name(for: location)
            }
        self.viewModel.results = locations ?? []
    }
    
    private func name(for location: Location) -> String {
        let name: String
        if let stopPoint = location.stopPoint {
            name = "StopPoint \(stopPoint.stopPointName.text)"
        } else if let stopPlace = location.stopPlace {
            name = "StopPlace \(stopPlace.stopPlaceName.text)"
        } else if let locality = location.locality {
            name = "Locality \(locality.localityName.text)"
        } else if let pointOfInterest = location.pointOfInterest {
            name = "PointOfInterest \(pointOfInterest.pointOfInterestName.text)"
        } else if let address = location.address {
            name = "Address \(address.streetName ?? "No Street")"
        } else {
            name = "Unknown Location"
        }
        
        return "\(name) (\(location.locationName.text))"
    }
    
    private func requestBody(for query: String) throws -> Data {
        guard let requestorRef = ProcessInfo.processInfo.environment["TRIAS_REQUESTOR_REF"] else {
            fatalError("NO REQUESTOR REF!")
        }
        
        let requestBody = APIRequestFactory.createLocationInformationRequest(for: query, requestorRef: requestorRef)
        let encoder = XMLEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(requestBody, withRootKey: "Trias", rootAttributes: [
            "version": "1.2",
            "xmlns": "http://www.vdv.de/trias",
            "xmlns:siri": "http://www.siri.org.uk/siri"
        ])
    }
    
    private func decodeRequest(_ request: URLRequest) async throws -> LocationInformationResponse {
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            print("Request returned HTTP \(response.statusCode):\n\(String(data: data, encoding: .utf8) ?? "NO DATA")")
        }
        let decoder = XMLDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(TriasResponse<LocationInformationResponse>.self, from: data)
        
        return decoded.serviceDelivery.payload.requestOrResponse
    }
}

#Preview {
    ContentView()
}
