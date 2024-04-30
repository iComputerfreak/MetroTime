// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

struct LocationContext: Codable {
    enum CodingKeys: String, CodingKey {
        case locationRef = "LocationRef"
        case tripLocation = "TripLocation"
        case depArrTime = "DepArrTime"
        case individualTransportOptions = "IndividualTransportOptions"
    }
    
    /// Angabe eines räumlichen Orts (vgl. 7.5.11).
    let locationRef: String?
    /// Aufenthaltsort in einem (sich bewegenden) Fahrzeug (vgl. 7.6.5).
    let tripLocation: TripLocation?
    
    /// Beabsichtigte Abfahrts- oder Ankunftszeit an dem in Location oder TripLocation bezeichneten Ort.
    let depArrTime: Date?
    /// Angaben des Benutzers, wie er/sie den Ort mittels IV erreichen/verlassen könnte (vgl. 7.3.2).
    let individualTransportOptions: [IndividualTransportOptions]?
}
