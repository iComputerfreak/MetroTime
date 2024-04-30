// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Struktur zum Filtern nach POI-Kategorien
struct PointOfInterestFilter: Codable {
    /// Legt fest, ob die nachfolgenden Kategorien bei der POI-Suche als einzige eingeschlossen (Exclude=`false`)
    /// oder ausgeschlossen werden sollen (Exclude=`true`). Default ist `false`.
    let exclude: Bool?
    /// Bezeichner für POI-Kategorien.
    ///
    /// Vgl. 7.5.6. Wenn mehrere aufgelistet sind, werden die Kategorien bei der Suche mit einem logischen „ODER“ (im Fall von Exclude=`false`)
    /// bzw. mit einem logischen „UND“ (im Fall von Exclude=`true`) berücksichtigt
    let pointOfInterestCategories: [PointOfInterestCategory]
}
