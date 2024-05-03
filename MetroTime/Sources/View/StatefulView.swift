// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

protocol StatefulView: View {
    associatedtype ViewModel: ViewModelProtocol
    
    /// The view model that contains the necessary data and business logic for this view
    var viewModel: ViewModel { get }
}
