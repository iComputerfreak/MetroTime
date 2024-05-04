// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

/// Represents an image that changes its style based on a variable passed in
///
/// The label either presents a "+" image or a checkmark, depending on whether `isAdded` is `true`
struct AddButtonLabel: View {
    let isAdded: Bool
    
    var body: some View {
        Image(systemName: isAdded ? "checkmark.circle" : "plus.circle")
            .foregroundStyle(isAdded ? .green : .accentColor)
    }
}

#Preview {
    List {
        HStack {
            Text(verbatim: "Test")
            Spacer()
            AddButtonLabel(isAdded: true)
        }
        HStack {
            Text(verbatim: "Test")
            Spacer()
            AddButtonLabel(isAdded: false)
        }
    }
}
