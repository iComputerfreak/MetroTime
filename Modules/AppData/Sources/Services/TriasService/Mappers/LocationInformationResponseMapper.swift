// Copyright © 2024 Jonas Frey. All rights reserved.

import AppFoundation
import Foundation
import JFUtils

/// Sorts `LocationResult`s by their probability
private struct LocationResultComparator: SortComparator {
    var order: SortOrder
    
    func compare(_ lhs: LocationResult, _ rhs: LocationResult) -> ComparisonResult {
        // Locations without a probability are sorted last
        guard !(lhs.probability == nil && rhs.probability == nil) else { return .orderedSame }
        guard let lhsProbability = lhs.probability else { return .orderedDescending }
        guard let rhsProbability = rhs.probability else { return .orderedAscending }
        
        if lhsProbability == rhsProbability {
            return .orderedSame
        } else if lhsProbability < rhsProbability {
            return .orderedAscending
        } else {
            return .orderedDescending
        }
    }
}

enum LocationInformationResponseMapper {
    enum Error: LocalizedError {
        case noLocations
        case noStopPoint
        case noLocality
        
        var errorDescription: String? {
            switch self {
            case .noLocations:
                return String(localized: "locationInformationResponseMapper.error.noLocations")
            
            case .noStopPoint:
                return String(localized: "locationInformationResponseMapper.error.noStopPoint")
            
            case .noLocality:
                return String(localized: "locationInformationResponseMapper.error.noLocality")
            }
        }
    }
    
    static func map(_ response: LocationInformationResponse) throws -> [Station] {
        if
            let messages = response.errorMessages,
            messages.isNotEmpty
        {
            let errors: [LocationInformationResponseError] = messages.map { errorMessage in
                    .init(rawValue: errorMessage) ?? .unknown
            }
            throw CompoundError(errors: errors)
        }
        
        guard let locations = response.locations else { throw Error.noLocations }
        
        return locations
            .sorted(using: LocationResultComparator(order: .reverse))
            .compactMap { locationResult in
                guard let stopPoint = locationResult.location.stopPoint else {
                    return nil
                }
                guard let localityRef = stopPoint.localityRef else {
                    return nil
                }
                let geoPosition = locationResult.location.geoPosition
                
                return Station(
                    id: stopPoint.stopPointRef,
                    name: stopPoint.stopPointName.text,
                    localityID: localityRef,
                    locality: locationResult.location.locationName.text,
                    latitude: geoPosition.latitude,
                    longitude: geoPosition.longitude,
                    altitude: geoPosition.altitude
                )
            }
    }
    
    static func map(_ response: TriasResponse<LocationInformationResponse>) throws -> [Station] {
        try map(ResponseMapper.map(response))
    }
}
