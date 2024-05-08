// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation
import SwiftUI

public extension View {
    /// Avoids hiding the toolbar content while searching
    ///
    /// - Important: This function is only available for iOS 17.1 and later. On older versions, this function does nothing.
    func searchPresentationToolbarAvoidHidingContent() -> some View {
        if #available(iOS 17.1, *) {
            return self.searchPresentationToolbarBehavior(.avoidHidingContent)
        } else {
            return self
        }
    }
}
