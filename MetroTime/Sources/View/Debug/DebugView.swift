// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct DebugView: View {
    var body: some View {
        List {
            NavigationLink {
                DebugStopsView()
            } label: {
                Label("Stops", systemImage: "bus")
            }
            
            NavigationLink {
                DebugAccentColorsView()
            } label: {
                Label("Colors", systemImage: "paintpalette")
            }
        }
    }
}

#Preview {
    NavigationStack {
        DebugView()
    }
}
