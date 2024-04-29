// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

enum TestingUtils {
    static func loadXML(_ name: String) -> Data {
        loadResource(name, ext: "xml")
    }
    
    static func loadResource(_ name: String, ext: String) -> Data {
        let bundle = Bundle.module
        let url = bundle.url(forResource: name, withExtension: ext)!
        return try! Data(contentsOf: url)
    }
}
