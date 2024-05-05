// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

// TODO: We shouldn't require requests to be decodable and responses to be encodable
struct ServicePayload<RequestOrResponse: Codable>: Codable {
    enum CodingKeys: CodingKey {
        case requestOrResponse(key: String)
        
        var stringValue: String {
            switch self {
            case let .requestOrResponse(key):
                return key
            }
        }
        
        init?(stringValue: String) {
            self = .requestOrResponse(key: stringValue)
        }
        
        var intValue: Int? {
            return nil
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    let requestOrResponse: RequestOrResponse
    
    init(requestOrResponse: RequestOrResponse) {
        self.requestOrResponse = requestOrResponse
    }
    
    init(from decoder: any Decoder) throws {
        let key = CodingKeys.requestOrResponse(key: String(describing: RequestOrResponse.self))
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.requestOrResponse = try container.decode(RequestOrResponse.self, forKey: key)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let key = CodingKeys.requestOrResponse(key: String(describing: RequestOrResponse.self))
        try container.encode(requestOrResponse, forKey: key)
    }
}
