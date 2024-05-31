// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

public extension ArraySlice {
    func asArray() -> [Element] {
        Array(self)
    }
}
