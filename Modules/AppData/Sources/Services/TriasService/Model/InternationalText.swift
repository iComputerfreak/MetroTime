// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

struct InternationalText: Codable {
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case textID = "TextId"
        case language = "Language"
    }
    
    let text: String
    let textID: String?
    let language: String?
    
    init(text: String, textID: String? = nil, language: String? = nil) {
        self.text = text
        self.textID = textID
        self.language = language
    }
}
