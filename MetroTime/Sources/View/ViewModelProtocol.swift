// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

protocol ViewModelProtocol: ObservableObject {
    static var `default`: Self { get }
}
