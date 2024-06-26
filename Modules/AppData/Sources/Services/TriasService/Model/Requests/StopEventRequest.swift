// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Fasst die Anfragedaten für eine Abfahrts- oder Ankunftstafel zusammen
struct StopEventRequest: Codable {
    enum CodingKeys: String, CodingKey {
        case location = "Location"
        case params = "Params"
    }
    
    /// Ortsdaten für die Abfahrts-/Ankunftstafel. Vgl. 7.6.11
    let location: LocationContext
    /// Spezifische Anfrageparameter. Vgl. 10.2.2.
    let params: StopEventParam?
    
    init(location: LocationContext, params: StopEventParam? = nil) {
        self.location = location
        self.params = params
    }
}
