// Copyright © 2024 Jonas Frey. All rights reserved.

import AppFoundation
import SwiftUI

enum LoadingState: Equatable {
    case loading
    case loaded
    case error(any Error)
    
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
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
    let retryAction: VoidCallback?
    let retryLabel: RetryLabel?
    let loadingBackground: Color?
    let completionView: () -> Content
    
    // swiftlint:disable:next type_contents_order
    init(
        loadingState: Binding<LoadingState>,
        retryAction: VoidCallback? = nil,
        retryLabel: RetryLabel? = nil as EmptyView?,
        loadingBackground: Color? = nil,
        @ViewBuilder completionView: @escaping () -> Content
    ) {
        self._loadingState = loadingState
        self.retryAction = retryAction
        self.retryLabel = retryLabel
        self.loadingBackground = loadingBackground
        self.completionView = completionView
    }
    
    var body: some View {
        switch loadingState {
        case .loaded, .loading:
            completionView()
                .overlay((loadingBackground ?? .systemBackground).opacity(loadingState == .loading ? 1 : 0))
                .overlay(ProgressView().opacity(loadingState == .loading ? 1 : 0))
        
        case let .error(error):
            ErrorView(error: error, retryAction: retryAction, retryLabel: retryLabel)
        }
    }
}

#Preview("Loading") {
    LoadingErrorView(loadingState: .constant(.loading), completionView: { Color.orange.ignoresSafeArea(edges: .all) })
}

#Preview("Loaded") {
    LoadingErrorView(loadingState: .constant(.loaded), completionView: { Text(verbatim: "Result") })
}

#Preview("Error") {
    LoadingErrorView(loadingState: .constant(.error(URLError(.badURL))), retryAction: { print("Retrying...") }, completionView: { EmptyView() })
}
