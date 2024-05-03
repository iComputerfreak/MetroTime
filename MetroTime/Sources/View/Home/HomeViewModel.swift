// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

final class HomeViewModel: ViewModelProtocol {
    @Published var stops: [String] = [
        "Karl-Wilhelm-Platz",
        "Europaplatz/Postgalerie (U)",
        "Otto-Sachs-Straße"
    ]
    
    func departures(for stop: String) -> [String] {
        return ["U1", "U2", "U3"]
    }
}

extension HomeViewModel {
    static let `default` = HomeViewModel()
}
