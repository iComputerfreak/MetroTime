// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Fasst die Daten Ortsobjektanfrage zusammen
struct LocationInformationRequest: Codable {
    enum CodingKeys: String, CodingKey {
        case initialInput = "InitialLocationInput"
        case locationRef = "LocationRef"
        case locationParam = "LocationParam"
    }
    
    /// Eingabedaten für eine initiale Ortsinformationsanfrage. Vgl. 8.3.2.
    let initialInput: InitialLocationInput?
    /// Referenz auf ein Ortsobjekt, welches weiter verfeinert werden soll.
    ///
    /// Bei hierarchisch organisierten Ortsobjekten kann es sinnvoll sein, die Ortsidentfikation in mehreren Stufen durchzuführen.
    /// Dabei erzeugt eine initiale Anfrage an den Ortsinformationsdienst eine Menge von „groben“ Ortsobjekten (z. B. Straßen),
    /// die ggf. noch weiter verfeinert werden müssen (z. B. zu Hausnummernbereichen).
    /// Die „groben“ Objekte werden dem Benutzer gezeigt und er wählt eines davon aus.
    /// Um dieses nun weiter zu verfeinern, wird seine Referenz hier dem Ortsinformationsdienst übergeben. Vgl. 7.5.11.
    let locationRef: LocationRef?
    /// Weitere Anfrageparameter. Vgl. 8.3.7.
    let locationParam: LocationParam?
    
    init(
        initialInput: InitialLocationInput? = nil,
        locationRef: LocationRef? = nil,
        locationParam: LocationParam? = nil
    ) {
        self.initialInput = initialInput
        self.locationRef = locationRef
        self.locationParam = locationParam
    }
}
