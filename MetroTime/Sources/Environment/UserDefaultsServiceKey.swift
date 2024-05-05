// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import SwiftUI

struct UserDefaultsServiceKey: EnvironmentKey {
    static let defaultValue: UserDefaultsService = RemoteUserDefaultsService()
}

extension EnvironmentValues {
    var userDefaultsService: UserDefaultsService {
        get { self[UserDefaultsServiceKey.self] }
        set { self[UserDefaultsServiceKey.self] = newValue }
    }
}
