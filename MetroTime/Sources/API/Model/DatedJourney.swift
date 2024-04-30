// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

enum DatedJourneyOccupancy: Codable {
    case manySeatsAvailable
    case fewSeatsAvailable
    case noSeatsAvailable
    case standingAvailable
    case full
}

// TODO: Inherited properties should be resolved by inheritance instead of duplication
struct DatedJourney: Codable {
    // MARK: Dated Service Group
    let operatingDayRef: String?
    let vehicleRef: String?
    let journeyRef: String
    let lineRef: String
    let directionRef: String
    let mode: IndividualMode
    
    // MARK: Service Origin
    /// ID des ersten Haltepunkts der Fahrt; Starthaltestelle. Vgl. 7.5.1.
    let originStopPointRef: String?
    /// Name des ersten Haltepunkts der Fahrt, der Starthaltestelle
    let originText: InternationalText?
    
    // MARK: Service Destination
    /// ID des letzten Haltepunkts der Fahrt; Endhaltestelle. Vgl. 7.5.1.
    let destinationStopPointRef: String?
    /// Name des letzten Haltepunkts der Fahrt, der Endhaltestelle
    let destinationText: InternationalText
    
    // MARK: Service Status
    /// Gibt an, ob es sich um eine zusätzliche, ungeplante Fahrt handelt. Voreinstellung ist `false`
    let unplanned: Bool?
    /// Gibt an, ob diese Fahrt zur Gänze entfällt. Voreinstellung ist `false`.
    let cancelled: Bool?
    /// Gibt an, ob diese Fahrt einen anderen Weg nimmt. Voreinstellung ist `false`
    let deviation: Bool?
    /// Auslastungszustand des Fahrzeugs
    let occupancy: DatedJourneyOccupancy?
    
    /// Verweis auf eine Störungsnachricht.
    ///
    /// Diese Nachricht kann im Kontext der Antwort (Response context) zu finden sein oder auf anderem Wege bekannt gemacht werden. Vgl.7.8.2.
    let situationFullRefs: [SituationFullRef]?
}
