// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

struct InternationalText: Decodable {
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case textID = "TextId"
        case language = "Language"
    }
    
    let text: String
    let textID: String?
    let language: String?
}
