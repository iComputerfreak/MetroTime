// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

public extension Error where Self: LocalizedError {
    var localizedDescription: String {
        return errorDescription ?? String(describing: self)
    }
}
