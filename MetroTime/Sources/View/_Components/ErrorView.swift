// Copyright © 2024 Jonas Frey. All rights reserved.

import AppFoundation
import SwiftUI

struct ErrorView<RetryLabel: View>: View {
    let error: Error
    let retryAction: VoidCallback?
    let retryLabel: RetryLabel?
    
    // swiftlint:disable:next type_contents_order
    init(error: Error, retryAction: VoidCallback? = nil, retryLabel: RetryLabel? = nil as EmptyView?) {
        self.error = error
        self.retryAction = retryAction
        self.retryLabel = retryLabel
    }
    
    var body: some View {
        ContentUnavailableView(label: {
            Label {
                Text("errorView.title")
            } icon: {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(.yellow)
            }
        }, description: {
            Text(error.localizedDescription)
        }, actions: {
            if let retryAction {
                Button(action: retryAction) {
                    if let retryLabel {
                        retryLabel
                    } else {
                        Text("errorView.retry")
                    }
                }
            }
        })
    }
}

#Preview {
    ErrorView(error: URLError(.badServerResponse))
}
