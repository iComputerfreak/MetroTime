// Copyright © 2024 Jonas Frey. All rights reserved.

import AppNetworking
import OSLog

public extension Logger {
    static let subsystem: String = Bundle.main.bundleIdentifier ?? ""
    
    init(_ category: String) {
        self.init(subsystem: Self.subsystem, category: category)
    }
}

public extension Logger {
    static let general = Logger("General")
    static let viewLifeCycle = Logger("ViewLifeCycle")
    static let network = Logger("Network")
    static let networkMapping = Logger("NetworkMapping")
    static let triasService = Logger("TriasService")
    static let userDefaultsService = Logger("UserDefaultsService")
}

extension Logger: LoggerProtocol {
    public func log(_ message: String) {
        self.log(level: .debug, "\(message)")
    }
}
