// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Halt einer Fahrt an einem Haltepunkt oder Haltestelle
struct CallAtStop: Codable {
    enum CodingKeys: String, CodingKey {
        case stopPointRef = "StopPointRef"
        case stopPointName = "StopPointName"
        case nameSuffix = "NameSuffix"
        case plannedBay = "PlannedBay"
        case estimatedBay = "EstimatedBay"
        case serviceArrival = "ServiceArrival"
        case serviceDeparture = "ServiceDeparture"
        case stopSeqNumber = "StopSeqNumber"
        case demandStop = "DemandStop"
        case unplannedStop = "UnplannedStop"
        case notServicedStop = "NotServicedStop"
        case situationFullRefs = "SituationFullRef"
    }
    
    // MARK: Stop Point
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
    
    // MARK: Service Arrival / Departure
    let serviceArrival: ServiceArrivalOrDeparture?
    let serviceDeparture: ServiceArrivalOrDeparture?
    
    // MARK: Stop Call Status
    /// Laufende Nummer des Halts im Fahrweg der Fahrt
    let stopSeqNumber: Int?
    /// Bedarfshalt. Fahrzeug bedient diesen Halt nur nach Voranmeldung.
    let demandStop: Bool?
    /// Halt, der laut Planung nicht vorgesehen war.
    let unplannedStop: Bool?
    /// Entgegen der Planung findet kein Halt statt.
    let notServicedStop: Bool?
    
    /// Verweis auf eine Störungsnachricht.
    ///
    /// Diese Nachricht kann im ResponseContext der Antwort zu finden sein oder auf anderem Wege bekannt gemacht werden.
    /// Vgl. 7.8.2.
    let situationFullRefs: [SituationFullRef]?
}
