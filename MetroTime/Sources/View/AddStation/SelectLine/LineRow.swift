// Copyright © 2024 Jonas Frey. All rights reserved.

import AppData
import AppDomain
import SwiftUI

struct LineRow: View {
    let line: any LineProtocol
    let isAdded: Bool
    
    var body: some View {
        HStack {
            Text(verbatim: "\(line.name) \(line.direction)")
            Spacer()
            AddButtonLabel(isAdded: isAdded)
        }
    }
}

#Preview {
    List {
        LineRow(line: Line(id: "1", name: "S1", directionID: "1", direction: "Bad Herrenalb"), isAdded: true)
        LineRow(line: Line(id: "2", name: "S1", directionID: "2", direction: "Hochstetten"), isAdded: false)
    }
}
