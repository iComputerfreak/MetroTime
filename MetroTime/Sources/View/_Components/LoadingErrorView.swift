// Copyright © 2024 Jonas Frey. All rights reserved.

import AppFoundation
import SwiftUI

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
        loadingBackground: Color = .systemBackground,
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
        case .idle, .loaded, .loading:
            completionView()
                .overlay(
                    loadingBackground
                        .ignoresSafeArea()
                        .containerRelativeFrame([.horizontal, .vertical])
                        .opacity(loadingState == .loading ? 1 : 0)
                )
                .overlay(ProgressView().opacity(loadingState == .loading ? 1 : 0))
        
        case let .error(error):
            ErrorView(error: error, retryAction: retryAction, retryLabel: retryLabel)
        }
    }
}

#Preview("Idle") {
    LoadingErrorView(loadingState: .constant(.idle), completionView: { Color.orange.ignoresSafeArea(edges: .all) })
}

#Preview("Loading") {
    LoadingErrorView(loadingState: .constant(.loading), loadingBackground: .green, completionView: { Text("Content Text") })
}

#Preview("Loaded") {
    LoadingErrorView(loadingState: .constant(.loaded), completionView: { Text(verbatim: "Result").background(.yellow) })
}

#Preview("Error") {
    LoadingErrorView(loadingState: .constant(.error(URLError(.badURL))), retryAction: { print("Retrying...") }, completionView: { EmptyView() })
}
