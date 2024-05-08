// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

enum DismissButtonLabel {
    case cancel
    case done
    case custom(LocalizedStringResource)
    
    var localized: String {
        switch self {
        case .cancel:
            return String(localized: "dismissButton.cancel")
        
        case .done:
            return String(localized: "dismissButton.done")
        
        case let .custom(stringKey):
            return String(localized: stringKey)
        }
    }
}

struct DismissButton: View {
    let label: DismissButtonLabel
    
    @Environment(\.dismiss)
    private var dismiss: DismissAction
    
    // swiftlint:disable:next type_contents_order
    init(label: DismissButtonLabel = .cancel) {
        self.label = label
    }
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text(label.localized)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        DismissButton()
        DismissButton(label: .done)
    }
}
