

import Foundation
import SwiftUI

extension Color {
    static func rgb(r: Double, g: Double, b: Double) -> Color {
        return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
    static let backgroundColor = Color.rgb(r: 21, g: 22, b: 33)
    static let outlineColor = Color.rgb(r: 54, g: 255, b: 203)
    static let pulsatingColor = Color.rgb(r: 139, g: 220, b: 255)
    static let appBlue = Color.rgb(r: 27, g: 174, b: 238)
    static let trackColor = Color.rgb(r: 57, g: 204, b: 255)
    static let omringColor = Color.rgb(r: 0, g: 123, b: 133)
    static let complimentaryForBlue = Color.rgb(r:238, g: 97, b: 27)
}
