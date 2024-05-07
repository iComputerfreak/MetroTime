// Copyright © 2024 Jonas Frey. All rights reserved.

import OSLog
import SwiftUI

struct DebugAccentColorsView: View {
    struct ColorSampleRow: View {
        let color: Color
        
        var body: some View {
            HStack(spacing: 8) {
                Circle()
                    .fill(color)
                    .frame(width: 30, height: 30)
                Text(String(describing: color).dropLast(2))
                    .bold()
                Spacer()
                Image(systemName: "house.fill")
                Image(systemName: "gear")
                Button {
                    // Do nothing
                } label: {
                    Text(verbatim: "Button")
                }
            }
            .tint(color)
            .foregroundStyle(color)
        }
    }
    
    @State private var colors: [Color] = [
        Color(red: 42 / 255, green: 167 / 255, blue: 189 / 255),
        Color(red: 55 / 255, green: 163 / 255, blue: 93 / 255),
        Color(red: 239 / 255, green: 133 / 255, blue: 78 / 255),
        Color(red: 197 / 255, green: 93 / 255, blue: 15 / 255),
        Color(red: 243 / 255, green: 185 / 255, blue: 13 / 255),
        Color(red: 236 / 255, green: 77 / 255, blue: 32 / 255),
        Color(red: 189 / 255, green: 89 / 255, blue: 149 / 255),
        Color(red: 232 / 255, green: 59 / 255, blue: 89 / 255),
        Color(red: 102 / 255, green: 3 / 255, blue: 128 / 255),
        Color(red: 184 / 255, green: 138 / 255, blue: 0 / 255),
        Color.orange
    ]
    
    @Environment(\.colorScheme)
    private var colorScheme: ColorScheme
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(colors, id: \.self) { color in
                    ColorSampleRow(color: color)
                }
            }
            .toolbar {
                toggleColorSchemeToolbarItem
                randomizeColorToolbarItem
            }
        }
    }
    
    @ToolbarContentBuilder private var toggleColorSchemeToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                toggleColorScheme()
            } label: {
                Image(systemName: colorScheme == .dark ? "sun.max.fill" : "moon.fill")
            }
        }
    }
    
    @ToolbarContentBuilder private var randomizeColorToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // Generate 10 new random colors
                colors = (1 ... 10).map { _ in .random() }
            } label: {
                Label("Randomize", systemImage: "shuffle")
            }
        }
    }
    
    private func toggleColorScheme() {
        guard
            let window = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive })
                .flatMap({ $0 as? UIWindowScene })?.windows
                .first 
        else {
            return
        }
        
        let currentStyle = window.overrideUserInterfaceStyle
        window.overrideUserInterfaceStyle = currentStyle == .dark ? .light : .dark
    }
}

private extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0 ... 1)
        let green = Double.random(in: 0 ... 1)
        let blue = Double.random(in: 0 ... 1)
        let color = Color(red: red, green: green, blue: blue)
        Logger.general.debug("Generated a new random color: \(String(describing: color).dropLast(2))")
        return color
    }
    
    static func randomOrange() -> Color {
        // Random hue in the orange range
        let hue = Double.random(in: 0 ... 30) / 360.0
        let saturation = Double.random(in: 0.5 ... 1.0)
        let brightness = Double.random(in: 0.7 ... 1.0)
        let color = Color(hue: hue, saturation: saturation, brightness: brightness)
        Logger.general.debug("Generated a new random color: \(String(describing: color).dropLast(2))")
        return color
    }
}

#Preview {
    DebugAccentColorsView()
}
