// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

struct LineDirectionFilter: Codable {
    enum CodingKeys: String, CodingKey {
        case line = "Line"
        case exclude = "Exclude"
    }
    
    /// Referenz auf die Linie (vgl. 7.4.5).
    let line: [LineDirection]
    /// Indikator, ob die Linien(richtungen) dieser Liste in die Suche aufgenommen oder von ihr ausgeschlossen werden sollen.
    /// Default ist Ausschluss (Exclude).
    let exclude: Bool?
    
    init(line: [LineDirection], exclude: Bool? = true) {
        self.line = line
        self.exclude = exclude
    }
}
