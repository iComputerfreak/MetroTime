// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Foundation
import SwiftUI

public final class Navigator: NavigatorProtocol {
    @Published public var path: NavigationPath
    
    init(path: NavigationPath = .init()) {
        self.path = path
    }
}
