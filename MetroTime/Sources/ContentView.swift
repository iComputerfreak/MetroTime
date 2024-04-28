// Copyright © 2024 Jonas Frey. All rights reserved.

import JFSwiftUI
import SwiftUI

public struct ContentView: View {
    // swiftlint:disable:next type_contents_order
    public init() {}

    public var body: some View {
        LoadingScreen(isLoading: true) {
            Text("Hello, World!")
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
