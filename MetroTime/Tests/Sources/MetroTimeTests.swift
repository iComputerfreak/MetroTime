@testable import MetroTime2

import Foundation
import XCTest
import XMLCoder

final class MetroTimeTests: XCTestCase {
    func testDecodeSample() throws {
        let data = loadXML("LocationInformationResponse")
        let coder = XMLDecoder()
        coder.dateDecodingStrategy = .iso8601
        let response = try coder.decode(TriasResponse<LocationInformationResponse>.self, from: data)
        
        XCTAssertEqual(response.serviceDelivery.status, true)
    }
    
    private func loadXML(_ name: String) -> Data {
        loadResource(name, ext: "xml")
    }
    
    private func loadResource(_ name: String, ext: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: ext)!
        return try! Data(contentsOf: url)
    }
}
