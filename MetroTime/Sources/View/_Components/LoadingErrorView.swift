// Copyright © 2024 Jonas Frey. All rights reserved.

import AppFoundation
import SwiftUI

enum LoadingState: Equatable {
    case loading
    case loaded
    case error(any Error)
    
    static func ==(lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
             (.loaded, .loaded):
            return true
        
        case let (.error(lhsError), .error(rhsError)):
            // Comparing the description is not ideal, but better than nothing
            return lhsError.localizedDescription == rhsError.localizedDescription
        
        default:
            return false
        }
    }
}

struct LoadingErrorView<Content: View, RetryLabel: View>: View {
    @Binding var loadingState: LoadingState
    let completionView: () -> Content
    let retryAction: VoidCallback?
    let retryLabel: RetryLabel?
    
    // swiftlint:disable:next type_contents_order
    init(
        loadingState: Binding<LoadingState>,
        @ViewBuilder completionView: @escaping () -> Content,
        retryAction: VoidCallback? = nil,
        retryLabel: RetryLabel? = nil as EmptyView?
    ) {
        self._loadingState = loadingState
        self.completionView = completionView
        self.retryAction = retryAction
        self.retryLabel = retryLabel
    }
    
    var body: some View {
        switch loadingState {
        case .loading:
            ProgressView()
        
        case .loaded:
            completionView()
        
        case let .error(error):
            ErrorView(error: error, retryAction: retryAction, retryLabel: retryLabel)
        }
    }
}

#Preview("Loading") {
    LoadingErrorView(loadingState: .constant(.loading), completionView: { EmptyView() })
}

#Preview("Loaded") {
    LoadingErrorView(loadingState: .constant(.loaded), completionView: { Text("Result") })
}

#Preview("Error") {
    LoadingErrorView(loadingState: .constant(.error(URLError(.badURL))), completionView: { EmptyView() }, retryAction: { print("Retrying...") })
}
