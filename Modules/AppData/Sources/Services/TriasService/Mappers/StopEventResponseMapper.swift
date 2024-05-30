// Copyright © 2024 Jonas Frey. All rights reserved.

import AppFoundation
import Foundation
import JFUtils
import OSLog

enum StopEventResponseMapper {
    enum Error: LocalizedError {
        case noStopEvents
        case noLineRef
        case noLineName
        case noDepartureInformation
        case noServiceSection
        case noDirectionRef
        
//        var errorDescription: String? {
//            switch self {
//            case .noStopEvents:
//                return String(localized: "stopEventResponseMapper.error.noStopEvents")
//            
//            case .noLineRef:
//                return String(localized: "stopEventResponseMapper.error.noLineRef")
//            
//            case .noLineName:
//                return String(localized: "stopEventResponseMapper.error.noLineName")
//            }
//        }
    }
    
    static func map(_ response: StopEventResponse) throws -> [Departure] {
        if  let errorMessage = response.errorMessage {
            guard let error = StopEventResponseError(rawValue: errorMessage.code) else {
                let errorText = errorMessage.text.map({ " (\"\($0.text)\")" }) ?? ""
                Logger.networkMapping.error("StopEventResponse contained unknown error code: \(errorMessage.code)\(errorText)")
                throw StopEventResponseError.unknown
            }
            throw error
        }
        
        guard let results = response.stopEventResults else { throw Error.noStopEvents }
        
        return try results
            .map { result in
                let service = result.stopEvent.service
                guard 
                    let departureInfo = result.stopEvent.thisCall.callAtStop.serviceDeparture,
                    let plannedDeparture = departureInfo.timetabledTime
                else {
                    throw Error.noDepartureInformation
                }
                guard let serviceSection = service.serviceSection else {
                    throw Error.noServiceSection
                }
                guard let lineRef = serviceSection.lineRef else {
                    throw Error.noLineRef
                }
                guard var lineName = serviceSection.publishedLineName?.text else {
                    throw Error.noLineName
                }
                guard let directionID = serviceSection.directionRef else {
                    throw Error.noDirectionRef
                }
                let directionName = result.stopEvent.service.destinationText.text
                
                // Try to remove the prefix of the line name (e.g., "Straßenbahn")
                if let prefix = serviceSection.mode?.name?.text {
                    lineName.removePrefix(prefix)
                }
                
                return Departure(
                    id: result.resultID,
                    stationID: result.stopEvent.thisCall.callAtStop.stopPointRef,
                    lineID: lineRef,
                    lineName: lineName,
                    directionID: directionID,
                    direction: directionName,
                    plannedDeparture: plannedDeparture,
                    estimatedDeparture: departureInfo.estimatedTime
                )
            }
    }
    
    static func map(_ response: TriasResponse<StopEventResponse>) throws -> [Departure] {
        try map(ResponseMapper.map(response))
    }
}
