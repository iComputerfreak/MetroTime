// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

public struct UnimplementedError: Error {
    public let code: String
    
    public init(code: String) {
        self.code = code
    }
}
