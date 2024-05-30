// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

public extension CodingKey {
    var description: String {
        let intValueDescription = intValue.map(String.init) ?? ""
        return stringValue.isEmpty ? intValueDescription : stringValue
    }
}

public extension Array where Element: CodingKey {
    var description: String {
        map(\.description).joined(separator: ".")
    }
}
