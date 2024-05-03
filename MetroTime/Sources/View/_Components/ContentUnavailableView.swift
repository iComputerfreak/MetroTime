// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

/// A simplified version of the `ContentUnavailableView` that supports iOS versions before iOS 17
struct ContentUnavailableView: View {
    let title: Text
    let image: Image
    let description: Text
    
    // swiftlint:disable:next type_contents_order
    init(title: Text, systemImage: String, description: Text) {
        self.image = Image(systemName: systemImage)
        self.title = title
        self.description = description
    }
    
    var body: some View {
        if #available(iOS 17.0, *) {
            SwiftUI.ContentUnavailableView("No Results.", systemImage: "magnifyingglass", description: Text("No stations could be found."))
                .frame(height: 180)
        } else {
            VStack {
                image
                    .foregroundStyle(.gray)
                    .font(.largeTitle.weight(.medium))
                    .imageScale(.large)
                    .padding(.bottom, 8)
                title
                    .font(.title2)
                    .bold()
                description
                    .foregroundStyle(.gray)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    ContentUnavailableView(title: Text("No Results."), systemImage: "magnifyingglass", description: Text("No stations could be found."))
}
