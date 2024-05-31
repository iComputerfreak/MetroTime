// Copyright © 2024 Jonas Frey. All rights reserved.

import AppDomain
import Foundation

enum APIRequestFactory {
    static func createLocationInformationRequest(
        searchString: String,
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
        includedLines: [any LineProtocol]?,
        requestorRef: String
    ) -> TriasRequest<StopEventRequest> {
        let lineFilter = includedLines.map { lines in
            LineDirectionFilter(
                line: lines.map { line in
                    LineDirection(lineRef: line.id, directionRef: line.directionID)
                }
            )
        }
        
        return TriasRequest(
            serviceRequest: .init(
                requestTimestamp: .now,
                requestorRef: requestorRef,
                payload: .init(
                    requestOrResponse: StopEventRequest(
                        location: LocationContext(
                            locationRef: LocationRef(
                                stopPointRef: stopID,
                                locationName: .init(text: "")
                            )
                        ),
                        params: StopEventParam(
                            lineFilter: lineFilter,
                            stopEventType: nil,
                            includeRealtimeData: true
                        )
                    )
                )
            )
        )
    }
}
