// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Verkehrsmittel mit Klassifizierung und Namen
struct Mode: Codable {
    enum CodingKeys: String, CodingKey {
        case ptMode = "PtMode"
        case airSubmode = "AirSubmode"
        case busSubmode = "BusSubmode"
        case coachSubmode = "CoachSubmode"
        case funicularSubmode = "FunicularSubmode"
        case metroSubmode = "MetroSubmode"
        case railSubmode = "RailSubmode"
        case telecabinSubmode = "TelecabinSubmode"
        case tramSubmode = "TramSubmode"
        case waterSubmode = "WaterSubmode"
        case name = "Name"
        case shortName = "ShortName"
        case description = "Description"
    }
    
    /// Angabe der ÖV-Verkehrsmittelart
    let ptMode: PTMode
    
    // MARK: PT Submode Choice Group
    /// Untertypen der Luftverkehrsmittel
    let airSubmode: AirSubmode?
    /// Untertypen der Busse
    let busSubmode: BusSubmode?
    /// Untertypen der Überlandbusse
    let coachSubmode: CoachSubmode?
    /// Untertypen der Seilbahnen
    let funicularSubmode: FunicularSubmode?
    /// Untertypen der Untergrundbahnen
    let metroSubmode: MetroSubmode?
    /// Untertypen der Züge
    let railSubmode: RailSubmode?
    /// Untertypen der Lift- und Aufzugsarten
    let telecabinSubmode: TelecabinSubmode?
    /// Untertypen der Straßenbahnen
    let tramSubmode: TramSubmode?
    /// Untertypen der Wasserverkehrsmittel
    let waterSubmode: WaterSubmode?
    
    // MARK: -
    /// Verkehrsmittelname
    let name: InternationalText?
    /// Kurzname oder Abkürzung
    let shortName: InternationalText?
    /// Beschreibender Text
    let description: InternationalText?
}
