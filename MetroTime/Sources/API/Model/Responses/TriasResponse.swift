// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

struct TriasResponse<Response: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case serviceDelivery = "ServiceDelivery"
    }
    
    let serviceDelivery: ServiceDelivery<Response>
}
