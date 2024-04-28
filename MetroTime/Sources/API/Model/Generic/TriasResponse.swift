// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

struct TriasResponse<Response: Decodable>: Decodable {
    enum CodingKeys: String, CodingKey {
        case serviceDelivery = "ServiceDelivery"
    }
    
    let serviceDelivery: ServiceDelivery<Response>
}
