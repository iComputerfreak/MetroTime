// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct ErrorView: View {
    let error: Error
    
    var body: some View {
//        ContentUnavailableView {
//            Text("errorView.title")
//        } description: {
//            Text(error.localizedDescription)
//        }
        Text("TODO")
    }
}

#Preview {
    ErrorView(error: URLError(.badServerResponse))
}
