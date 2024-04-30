// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

enum APIRequestFactory {
    static func createLocationInformationRequest(
        for searchString: String,
        requestorRef: String,
        allowedTypes: [LocationParamType] = [.stop]
    ) -> TriasRequest<LocationInformationRequest> {
        TriasRequest(
            serviceRequest: .init(
                requestTimestamp: .now,
                requestorRef: requestorRef,
                payload: .init(
                    requestOrResponse: LocationInformationRequest(
                        initialInput: .init(
                            locationName: searchString
                        ),
                        locationParam: .init(
                            types: allowedTypes
                        )
                    )
                )
            )
        )
    }
    
    static func createStopEventRequest(
        for stopID: String,
        requestorRef: String
    ) -> TriasRequest<StopEventRequest> {
        TriasRequest(
            serviceRequest: .init(
                requestTimestamp: .now,
                requestorRef: requestorRef,
                payload: .init(
                    requestOrResponse: StopEventRequest(
                        location: .init(locationRef: stopID),
                        params: .init(
                            lineFilter: nil,
                            stopEventType: .departure,
                            includeRealtimeData: true
                        )
                    )
                )
            )
        )
    }
}
