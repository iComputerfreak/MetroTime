// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Klassifizierung der Individualverkehrsarten
enum IndividualMode: String, Codable {
    case walk
    case cycle
    case taxi
    case selfDriveCar = "self-drive-car"
    case othersDriveCar = "others-drive-car"
    case motorcycle
    case truck
}
