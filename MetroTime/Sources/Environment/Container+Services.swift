// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import Factory
import SwiftUI

extension Container {
    var userDefaultsService: Factory<any UserDefaultsService> {
        self { RemoteUserDefaultsService() }
            .singleton
    }
    
    var triasService: Factory<TriasService> {
        self { RemoteTriasService() }
            .singleton
    }
}
