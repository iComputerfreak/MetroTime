// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

// TODO: Remove when TriasService is implemented

/// - Note: API documentation available at https://www.vdv.de/431-2sds-v1.1.pdfx
actor TriasAPI: ObservableObject {
    enum Path: String {
        case test
    }
    
    private let decoder = JSONDecoder()
    
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    private func request<T: Decodable>(path: Path, queryItems: [URLQueryItem]? = nil) async throws -> T {
        let url = baseURL.appendingPathComponent(path.rawValue)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryItems
        
        guard let requestURL = urlComponents?.url else {
            throw Error.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: requestURL)
        
        guard
            let httpResponse = response as? HTTPURLResponse,
            (200 ... 299) ~= httpResponse.statusCode
        else {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(T.self, from: data)
    }
}

extension TriasAPI {
    enum Error: Swift.Error {
        case invalidURL
    }
}
