// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

struct ServiceViaPoint: Codable {
    enum CodingKeys: String, CodingKey {
        case stopPointRef = "StopPointRef"
        case stopPointName = "StopPointName"
        case nameSuffix = "NameSuffix"
        case plannedBay = "PlannedBay"
        case estimatedBay = "EstimatedBay"
        case displayPriority = "DisplayPriority"
    }
    
    /// Referenz auf einen Code für einen Haltepunkt. Vgl. 7.5.1.
    let stopPointRef: String
    /// Name des Haltepunkts für Fahrgastinformation.
    let stopPointName: InternationalText
    /// Namenszusatz, der bei Platzmangel evtl. auch weggelassen werden kann, z. B.: „gegenüber vom Haupteingang“.
    let nameSuffix: InternationalText?
    /// Name des Steigs/Haltepunkts, wo in das Fahrzeug ein- oder ausgestiegen werden muss
    /// (bei Verwendung in Zusammenhang mit einer konkreten Verbindungsauskunft, wenn in StopPointName ein allgemeiner Name angegeben ist,
    /// ähnlich Haltestellenname).
    /// Nach Planungsstand.
    let plannedBay: InternationalText?
    /// Name des Steigs/Haltepunkts, wo in das Fahrzeug ein- oder ausgestiegen werden muss
    /// (bei Verwendung in Zusammenhang mit einer konkreten Verbindungsauskunft, wenn in StopPointName ein allgemeiner Name angegeben ist,
    /// ähnlich Haltestellenname).
    /// Nach letztem Prognosestand.
    let estimatedBay: InternationalText?
    /// Priorität, mit der dieser Via-Punkt angezeigt werden soll (z. B. falls Platz knapp ist und nicht alle Via-Punkte angezeigt werden können).
    let displayPriority: Int?
}
