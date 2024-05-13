// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation
import OSLog

enum ResponseMapper {
    /// Maps a given `TriasResponse` to its payload
    ///
    /// If the `TriasResponse` is in an error state, the error is thrown.
    static func map<T>(_ response: TriasResponse<T>) -> T {
        if response.serviceDelivery.status == false {
            Logger.networkMapping.error(
                "TriasResponse returned status == false. Error condition '\(String(describing: response.serviceDelivery.errorCondition))'"
            )
        }
        return response.serviceDelivery.payload.requestOrResponse
    }
}
