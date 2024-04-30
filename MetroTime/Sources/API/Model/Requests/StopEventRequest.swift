// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Fasst die Anfragedaten für eine Abfahrts- oder Ankunftstafel zusammen
struct StopEventRequest: Encodable {
    /// Ortsdaten für die Abfahrts-/Ankunftstafel. Vgl. 7.6.11
    let location: LocationContext
    /// Spezifische Anfrageparameter. Vgl. 10.2.2.
    let params: StopEventParam?
}

struct LocationContext: Codable {
    /// Angabe eines räumlichen Orts (vgl. 7.5.11).
    let locationRef: String?
    /// Aufenthaltsort in einem (sich bewegenden) Fahrzeug (vgl. 7.6.5).
    let tripLocation: TripLocation?
    
    /// Beabsichtigte Abfahrts- oder Ankunftszeit an dem in Location oder TripLocation bezeichneten Ort.
    let depArrTime: Date?
    /// Angaben des Benutzers, wie er/sie den Ort mittels IV erreichen/verlassen könnte (vgl. 7.3.2).
    let individualTransportOptions: [IndividualTransportOption]?
}
