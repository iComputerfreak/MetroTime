// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Fasst die Anfrageparameter zusammen, die eine initiale Suche nach Ortsobjekten benötigt
struct InitialLocationInput: Codable {
    enum CodingKeys: String, CodingKey {
        case locationName = "LocationName"
        case geoPosition = "GeoPosition"
        case geoRestriction = "GeoRestriction"
    }
    
    /// Eingabezeichenkette, die als Muster für die zu findenden Ortsobjekte dienen soll.
    ///
    /// Falls angegeben, sollen Ortsobjekte umso mehr bevorzugt werden, je ähnlicher ihr Name der Zeichenkette ist.
    /// Falls gleichzeitig GeoPosition angegeben wird, muss der Dienst beide Anforderungen sinnvoll zueinander gewichten
    let locationName: String?
    /// Geografische Position, in dessen Nähe die zu findenden Ortsobjekte liegen sollen.
    ///
    /// Falls angegeben, sollen solche Ortsobjekte bevorzugt werden, die in der Nähe dieser Geoposition liegen.
    /// Falls gleichzeitig LocationName angegeben wird, muss der Dienst beide Anforderungen sinnvoll zueinander gewichten. Vgl. 7.2.3.
    let geoPosition: GeoPosition?
    /// Geografischer Filter. Falls angegeben, müssen alle gefundenene Ortsobjekte diesem Filter entsprechen. Vgl. 8.3.3.
    let geoRestriction: GeoRestrictions?
}
