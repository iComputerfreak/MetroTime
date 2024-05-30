// Copyright © 2024 Jonas Frey. All rights reserved.

import AppNetworking
import Foundation
import XMLCoder

public final class TriasXMLEncoder: XMLEncoder, Encoder {
    var rootKey: String?
    var rootAttributes: [String: String]?
    var header: XMLHeader?
    var doctype: XMLDocumentType?
    
    public init(rootKey: String? = nil, rootAttributes: [String: String]? = nil, header: XMLHeader? = nil, doctype: XMLDocumentType? = nil) {
        self.rootKey = rootKey
        self.rootAttributes = rootAttributes
        self.header = header
        self.doctype = doctype
    }
    
    override public func encode<T>(_ value: T) throws -> Data where T: Encodable {
        try self.encode(value, withRootKey: rootKey, rootAttributes: rootAttributes, header: header, doctype: doctype)
    }
}
