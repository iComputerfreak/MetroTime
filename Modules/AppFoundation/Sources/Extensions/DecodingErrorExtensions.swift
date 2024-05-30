// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

public extension DecodingError {
    var localizedDescription: String? {
        switch self {
        case let .typeMismatch(expectedType, context):
            return "Type mismatch at key path: \(keyPathString(from: context)). Expected type: \(String(describing: expectedType))"
        
        case let .valueNotFound(expectedValueType, context):
            return "Value of type \(String(describing: expectedValueType)) not found at key path: \(keyPathString(from: context))"
        
        case let .keyNotFound(key, context):
            return "Key '\(key.stringValue)' not found at key path: \(keyPathString(from: context))"
        
        case let .dataCorrupted(context):
            return "Data corrupted at key path: \(keyPathString(from: context))"
        
        @unknown default:
            return "Unknown error"
        }
    }
    
    private func keyPathString(from context: DecodingError.Context) -> String {
        return context.codingPath.map { $0.stringValue }.joined(separator: ".")
    }
}
