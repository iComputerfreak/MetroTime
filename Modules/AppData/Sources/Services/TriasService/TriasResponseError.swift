// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

enum TriasResponseError: LocalizedError {
    case siriError(String?)
    
    var errorDescription: String? {
        switch self {
        case let .siriError(errorCondition):
            return "There was an error performing the request\(errorCondition.map { ": \($0)" } ?? "")"
        }
    }
}
