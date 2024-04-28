// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

struct DeliveryPayload<Response: Decodable>: Decodable {
    enum CodingKeys: CodingKey {
        case response(key: String)
        
        var stringValue: String {
            switch self {
            case let .response(key):
                return key
            }
        }
        
        init?(stringValue: String) {
            self = .response(key: stringValue)
        }
        
        var intValue: Int? {
            return nil
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    let response: Response
    
    init(from decoder: any Decoder) throws {
        let key = CodingKeys.response(key: String(describing: Response.self))
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try container.decode(Response.self, forKey: key)
    }
}
