// Copyright © 2024 Jonas Frey. All rights reserved.

import Factory
import SwiftUI

extension View {
    func injectPreviewEnvironment() -> some View {
        Container.shared.userDefaultsService.register(factory: { PreviewUserDefaultsService() })
        Container.shared.triasService.register(factory: { PreviewTriasService() })
        return self
    }
}
