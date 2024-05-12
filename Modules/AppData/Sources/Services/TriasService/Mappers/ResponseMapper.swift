// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

enum ResponseMapper {
    /// Maps a given `TriasResponse` to its payload
    ///
    /// If the `TriasResponse` is in an error state, the error is thrown.
    static func map<T>(_ response: TriasResponse<T>) throws -> T {
        guard response.serviceDelivery.status != false else {
            throw TriasResponseError.siriError(response.serviceDelivery.errorCondition)
        }
        return response.serviceDelivery.payload.requestOrResponse
    }
}
