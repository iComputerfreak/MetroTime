// Copyright © 2024 Jonas Frey. All rights reserved.

import OSLog

extension Logger {
    static let subsystem: String = Bundle.main.bundleIdentifier ?? ""
    
    init(_ category: String) {
        self.init(subsystem: Self.subsystem, category: category)
    }
}

extension Logger {
    static let general = Logger("General")
    static let viewLifeCycle = Logger("ViewLifeCycle")
    static let network = Logger("Network")
    static let triasService = Logger("TriasService")
    static let userDefaultsService = Logger("UserDefaultsService")
}
