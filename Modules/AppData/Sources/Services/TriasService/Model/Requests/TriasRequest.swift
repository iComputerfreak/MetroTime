// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

struct TriasRequest<Request: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case serviceRequest = "ServiceRequest"
    }
    
    let serviceRequest: ServiceRequest<Request>
}
