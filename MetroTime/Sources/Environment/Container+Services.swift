// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import Factory
import SwiftUI

extension Container {
    var userDefaultsService: Factory<UserDefaultsService> {
        self { RemoteUserDefaultsService() }
    }
    
    var triasService: Factory<TriasService> {
        self { RemoteTriasService() }
    }
}
