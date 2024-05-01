// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

struct SettingsView: View {
    /*
     Colors:
     #BD5995 rgb(189, 89, 149)
     #B22F6F rgb(178, 47, 111)
     #E93A58 rgb(233, 58, 88)
     #660180 rgb(102, 1, 128)
     #AC4B68 rgb(172, 75, 104)
     #2AA7BD rgb(42, 167, 189)
     #37A35D rgb(55, 163, 93)
     #EF854E rgb(239, 133, 78)
     #C55D0F rgb(197, 93, 15)
     #F3B90D rgb(243, 185, 13)
     #EC4D20 rgb(236, 77, 32)
     
     #E9841E
     #FC9210
     #FC621A
     
     #F3B90D !!!
     
     */
    // swiftlint:disable operator_usage_whitespace
    @State private var colors: [Color] = [
        Color(red: 42/255, green: 167/255, blue: 189/255),
        Color(red: 55/255, green: 163/255, blue: 93/255),
        Color(red: 239/255, green: 133/255, blue: 78/255),
        Color(red: 197/255, green: 93/255, blue: 15/255),
        Color(red: 243/255, green: 185/255, blue: 13/255),
        Color(red: 236/255, green: 77/255, blue: 32/255),
        Color(red: 189/255, green: 89/255, blue: 149/255),
//        Color(red: 0.70, green: 0.18, blue: 0.41),
        Color(red: 0.91, green: 0.23, blue: 0.35),
        Color(red: 0.40, green: 0.01, blue: 0.50),
    ]
    // swiftlint:enable operator_usage_whitespace
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(colors, id: \.self) { color in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(color)
                            .frame(width: 30, height: 30)
                        Text(String(describing: color).dropLast(2))
                            .bold()
                        Spacer()
                        Image(systemName: "house.fill")
                        Image(systemName: "gear")
                        Button {} label: {
                            Text("Button")
                        }
                    }
                    .tint(color)
                    .foregroundStyle(color)
                    //                .font(.system(size: 22))
                }
            }
            .toolbar {
                // Leading button to switch dark/light mode
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = UIApplication.shared.windows.first?.overrideUserInterfaceStyle == .dark ? .light : .dark
                    } label: {
                        Image(systemName: UIApplication.shared.windows.first?.overrideUserInterfaceStyle == .dark ? "sun.max.fill" : "moon.fill")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        colors = Array(repeating: Color.black, count: 10).map { _ in .random() }
                    } label: {
                        Label("Randomize", systemImage: "shuffle")
                    }
                }
            }
        }
    }
}

// Red: 1
// Blue: <= 0.4
// Green: random

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0.9 ... 1)
        let green = Double.random(in: 0 ... 1)
        let blue = Double.random(in: 0 ... 0.2)
        let color = Color(red: red, green: green, blue: blue)
        print(String(describing: color).dropLast(2))
        return color
    }
}

extension Color {
    static func randomOrange() -> Color {
        let hue = Double.random(in: 0...30) / 360.0 // Random hue in the orange range
        let saturation = Double.random(in: 0.5...1.0) // Random saturation
        let brightness = Double.random(in: 0.7...1.0) // Random brightness
        
        return Color(hue: hue, saturation: saturation, brightness: brightness)
    }
}


#Preview {
    SettingsView()
}
