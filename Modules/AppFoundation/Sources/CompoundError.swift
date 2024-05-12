// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

public struct CompoundError: Error {
    public let errors: [Error]
    
    public init(errors: [Error]) {
        self.errors = errors
    }
}
