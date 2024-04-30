// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

enum StopEventType: String, Codable {
    case departure
    case arrival
    case both
}

/// Fasst die Anfrageparameter zusammen, die die Berechnung einer Abfahrts- oder Ankunftstafel steuern
struct StopEventParam: Codable {
    enum CodingKeys: String, CodingKey {
        case ptModeFilter = "PtModeFilter"
        case lineFilter = "LineFilter"
        case operatorFilter = "OperatorFilter"
        case numberOfResults = "NumberOfResults"
        case timeWindow = "TimeWindow"
        case stopEventType = "StopEventType"
        case includePreviousCalls = "IncludePreviousCalls"
        case includeOnwardCalls = "IncludeOnwardCalls"
        case includeOperatingDays = "IncludeOperatingDays"
        case includeRealtimeData = "IncludeRealtimeData"
    }
    
    // MARK: Stop Event Data Filter
    /// Erlaubte Verkehrsmittel. Vgl. 7.3.5.
    let ptModeFilter: PTModeFilter?
    /// Erlaubte Linien (ggf. verfeinert auf Richtungen). Vgl. 7.4.6
    let lineFilter: LineDirectionFilter?
    /// Erlaubte Verkehrsunternehmen. Vgl. 7.4.4.
    let operatorFilter: OperatorFilter?
    
    // MARK: Stop Event Policy
    /// Maximale Zahl von Abfahrts-/Ankunftsereignissen, die in der Antwort zurückgegeben werden sollen
    let numberOfResults: Int?
    /// Zeitfenster, in dem Abfahrts-/Ankunftsereignisse in der Antwort zurückgegeben werden sollen.
    /// Wird gerechnet ab dem in LocationContext angegebenen Zeitpunkt
    let timeWindow: XMLDuration?
    /// Gibt an, ob Abfahrts- oder Ankunftsereignisse oder beides zurückgegeben werden sollen
    let stopEventType: StopEventType?
    
    // MARK: Stop Event Content Filter
    /// Gibt an, ob je Fahrt die vorausgehenden Halte angeführt werden sollen
    let includePreviousCalls: Bool?
    /// Gibt an, ob je Fahrt die nachfolgenden Halte angeführt werden sollen
    let includeOnwardCalls: Bool?
    /// Gibt an, ob die Verkehrstage der Fahrten angegeben werden sollen
    let includeOperatingDays: Bool?
    /// Steuert, ob Echtzeitdaten berücksichtigt und ausgegeben werden sollen
    let includeRealtimeData: Bool?
}
