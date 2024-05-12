// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// An error that can be present in an LocationInformationResponse
public enum LocationInformationResponseError: String, LocalizedError {
    case noResults = "LOCATION_NORESULTS"
    case unsupportedType = "LOCATION_UNSUPPORTEDTYPE"
    case unsupportedCombination = "LOCATION_UNSUPPORTEDCOMBINATION"
    case noRefinement = "LOCATION_NOREFINEMENT"
    case usageIgnored = "LOCATION_USAGEIGNORED"
    case unsupportedPTModes = "LOCATION_UNSUPPORTEDPTMODES"
    case unsupportedLocality = "LOCATION_UNSUPPORTEDLOCALITY"
    case unknown = "UNKNOWN_ERROR"
    
    public var errorDescription: String? {
        switch self {
        case .noResults:
            return String(localized: "locationInformationResponseError.noResults")
            
        case .unsupportedType:
            return String(localized: "locationInformationResponseError.unsupportedType")
            
        case .unsupportedCombination:
            return String(localized: "locationInformationResponseError.unsupportedCombination")
            
        case .noRefinement:
            return String(localized: "locationInformationResponseError.noRefinement")
            
        case .usageIgnored:
            return String(localized: "locationInformationResponseError.usageIgnored")
            
        case .unsupportedPTModes:
            return String(localized: "locationInformationResponseError.unsupportedPTModes")
            
        case .unsupportedLocality:
            return String(localized: "locationInformationResponseError.unsupportedLocality")
        
        case .unknown:
            return String(localized: "locationInformationResponseError.unknown")
        }
    }
}
