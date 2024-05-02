// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Text("Settings")
            .toolbar {
                #if DEBUG
                    debugButton
                #endif
            }
        }
    }
    
    @ToolbarContentBuilder var debugButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                DebugView()
            } label: {
                Label("Debug", systemImage: "ladybug")
            }
        }
    }
}

#Preview {
    SettingsView()
}
