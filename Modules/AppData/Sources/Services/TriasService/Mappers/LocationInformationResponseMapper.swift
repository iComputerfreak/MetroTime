// Copyright © 2024 Jonas Frey. All rights reserved.

import AppFoundation
import Foundation

enum LocationInformationResponseMapper {
    static func map(_ response: LocationInformationResponse) throws -> [Station] {
        // TODO: Only throw error if there are really no events
        if
            let messages = response.errorMessages,
            messages.isNotEmpty
        {
            let errors: [LocationInformationResponseError] = messages.map { errorMessage in
                    .init(rawValue: errorMessage) ?? .unknown
            }
            throw CompoundError(errors: errors)
        }
        return []
    }
    
    static func map(_ response: TriasResponse<LocationInformationResponse>) throws -> [Station] {
        try map(ResponseMapper.map(response))
    }
}
