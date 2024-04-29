@testable import MetroTime2

import Foundation
import XCTest
import XMLCoder

final class MetroTimeTests: XCTestCase {
    var decoder: XMLDecoder!
    
    override func setUpWithError() throws {
        decoder = XMLDecoder()
        decoder.dateDecodingStrategy = .iso8601
    }
}

// MARK: - Decoding
extension MetroTimeTests {
    func testDecodeSample() throws {
        let data = TestingUtils.loadXML("LocationInformationResponse")
        let response = try decoder.decode(TriasResponse<LocationInformationResponse>.self, from: data)
        
        // 2024-04-28T13:38:58Z
        let expectedDate = DateComponents(
            calendar: .current,
            timeZone: .gmt,
            year: 2024,
            month: 4,
            day: 28,
            hour: 13,
            minute: 38,
            second: 58
        ).date!
        
        XCTAssertEqual(response.serviceDelivery.responseTimestamp, expectedDate)
        XCTAssertEqual(response.serviceDelivery.producerRef, "EFAController10.3.18.46-EFA03")
        XCTAssertEqual(response.serviceDelivery.status, true)
        XCTAssertEqual(response.serviceDelivery.moreData, false)
        XCTAssertEqual(response.serviceDelivery.language, "de")
        XCTAssertEqual(response.serviceDelivery.calcTime, 576)
        
        let payload = response.serviceDelivery.payload.response
        XCTAssertNil(payload.continueAt)
        XCTAssertNil(payload.errorMessages)
        
        // First payload:
        //
        // <LocationResult>
        //     <Location>
        //         <StopPoint>
        //             <StopPointRef>de:08212:508</StopPointRef>
        //             <StopPointName>
        //                 <Text>Otto-Sachs-Straße</Text>
        //                 <Language>de</Language>
        //             </StopPointName>
        //             <LocalityRef>8212000:15</LocalityRef>
        //             <WheelchairAccessible>false</WheelchairAccessible>
        //             <Lighting>false</Lighting>
        //             <Covered>false</Covered>
        //         </StopPoint>
        //         <LocationName>
        //             <Text>Karlsruhe</Text>
        //             <Language>de</Language>
        //         </LocationName>
        //         <GeoPosition>
        //             <Longitude>8.38938</Longitude>
        //             <Latitude>49.00345</Latitude>
        //         </GeoPosition>
        //     </Location>
        //     <Complete>true</Complete>
        //     <Probability>0.972000003</Probability>
        // </LocationResult>
        
        let firstResult = try XCTUnwrap(payload.locations?.first)
        XCTAssertEqual(firstResult.complete, true)
        XCTAssertEqual(firstResult.probability, 0.972000003)
        
        let location = firstResult.location
        XCTAssertEqual(location.locationName.language, "de")
        XCTAssertEqual(location.locationName.text, "Karlsruhe")
        XCTAssertEqual(location.geoPosition.latitude, 49.00345)
        XCTAssertEqual(location.geoPosition.longitude, 8.38938)
        
        let stopPoint = try XCTUnwrap(location.stopPoint)
        XCTAssertEqual(stopPoint.stopPointRef, "de:08212:508")
        XCTAssertEqual(stopPoint.stopPointName.language, "de")
        XCTAssertEqual(stopPoint.stopPointName.text, "Otto-Sachs-Straße")
        XCTAssertEqual(stopPoint.localityRef, "8212000:15")
        XCTAssertEqual(stopPoint.wheelchairAccessible, false)
        XCTAssertEqual(stopPoint.lighting, false)
        XCTAssertEqual(stopPoint.covered, false)
    }
}
