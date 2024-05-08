// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation
import SwiftUI

public protocol NavigatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
}
