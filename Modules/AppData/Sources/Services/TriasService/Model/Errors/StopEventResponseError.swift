// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// An error that can be present in an StopEventResponse
public enum StopEventResponseError: String, LocalizedError {
    case dateOutOfRange = "STOPEVENT_DATEOUTOFRANGE"
    case locationUnknown = "STOPEVENT_LOCATIONUNKNOWN"
    case locationUnserved = "STOPEVENT_LOCATIONUNSERVED"
    case noEventFound = "STOPEVENT_NOEVENTFOUND"
    case unknown = "UNKNOWN_ERROR"
    
    public var errorDescription: String? {
        switch self {
        case .dateOutOfRange:
            return String(localized: "stopEventResponseError.dateOutOfRange")
        
        case .locationUnknown:
            return String(localized: "stopEventResponseError.locationUnknown")
        
        case .locationUnserved:
            return String(localized: "stopEventResponseError.locationUnserved")
        
        case .noEventFound:
            return String(localized: "stopEventResponseError.noEventFound")
        
        case .unknown:
            return String(localized: "locationInformationResponseError.unknown")
        }
    }
}
