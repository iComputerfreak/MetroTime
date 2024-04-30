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
                ForEach(Array(viewModel.results.sorted().enumerated()), id: \.offset) { _, result in
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
        guard let requestorRef = ProcessInfo.processInfo.environment["TRIAS_REQUESTOR_REF"] else {
            print("NO REQUESTOR REF!")
            return
        }
        let timestamp = ISO8601DateFormatter().string(from: .now)
        
        let session = URLSession.shared
        let url = URL(string: "https://projekte.kvv-efa.de/freytrias/trias")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("text/xml", forHTTPHeaderField: "Content-Type")
        request.httpBody = """
        <Trias version="1.2" xmlns="http://www.vdv.de/trias" xmlns:siri="http://www.siri.org.uk/siri">
            <ServiceRequest>
                <siri:RequestorRef>\(requestorRef)</siri:RequestorRef>
                <siri:RequestTimestamp>\(timestamp)</siri:RequestTimestamp>
                <RequestPayload>
                    <LocationInformationRequest>
                        <InitialInput>
                            <LocationName>\(query)</LocationName>
                        </InitialInput>
                    </LocationInformationRequest>
                </RequestPayload>
            </ServiceRequest>
        </Trias>
        """.data(using: .utf8)
        
        let (data, response) = try await session.data(for: request)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            print("Request returned HTTP \(response.statusCode):\n\(String(data: data, encoding: .utf8) ?? "NO DATA")")
        }
        let decoder = XMLDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(TriasResponse<LocationInformationResponse>.self, from: data)
        print(decoded)
        let locations = decoded.serviceDelivery.payload.response.locations?
            .compactMap { result in
                let location = result.location
                let locationName = location.locationName.text
                let stopName = location.stopPoint?.stopPointName.text
                return "\(stopName ?? "") (\(locationName))"
            }
        self.viewModel.results = locations ?? []
    }
}

#Preview {
    ContentView()
}
