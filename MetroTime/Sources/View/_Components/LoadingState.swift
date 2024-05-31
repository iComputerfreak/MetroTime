// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation
import SwiftUI

enum LoadingState: Equatable {
    case idle
    case loading
    case loaded
    case error(any Error)
    
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
            (.loaded, .loaded),
            (.idle, .idle):
            return true
        
        case let (.error(lhsError), .error(rhsError)):
            // Comparing the description is not ideal, but better than nothing
            return lhsError.localizedDescription == rhsError.localizedDescription
        
        default:
            return false
        }
    }
}
