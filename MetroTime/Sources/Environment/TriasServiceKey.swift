// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import SwiftUI

struct TriasServiceKey: EnvironmentKey {
    static let defaultValue: TriasService = RemoteTriasService()
}

extension EnvironmentValues {
    var triasService: TriasService {
        get { self[TriasServiceKey.self] }
        set { self[TriasServiceKey.self] = newValue }
    }
}
