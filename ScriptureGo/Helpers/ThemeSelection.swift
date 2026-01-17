//
//  ThemeSelection.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 1/14/26.
//

import Foundation
import SwiftUI
import Combine

final class ThemeManager: ObservableObject {
    @Published var current: Theme = AppTheme.parchment
}

struct Theme {
    let primary: Color
    let secondary: Color
    let background: Color
    let textPrimary: Color
    let textSecondary: Color
    let accent: Color
    let warning: Color
}

enum AppTheme {
    static let parchment = Theme(
        primary: Color(red: 135/255, green: 90/255, blue: 60/255),
        secondary: Color(red: 220/255, green: 205/255, blue: 190/255),
        background: Color(red: 245/255, green: 235/255, blue: 220/255),
        textPrimary: Color(red: 60/255, green: 55/255, blue: 50/255),
        textSecondary: Color(red: 120/255, green: 115/255, blue: 110/255),
        accent: Color(red: 110/255, green: 125/255, blue: 90/255),
        warning: Color(red: 165/255, green: 75/255, blue: 60/255)
    )
    
    static let meadow = Theme(
        // Buttons & main actions (soft sky blue)
        primary: Color(red: 155/255, green: 195/255, blue: 225/255),

        // Large background elements / cards (sage green)
        secondary: Color(red: 195/255, green: 220/255, blue: 200/255),

        // Main background (warm floral cream)
        background: Color(red: 250/255, green: 246/255, blue: 240/255),

        // Main readable text (soft charcoal, not pure black)
        textPrimary: Color(red: 60/255, green: 65/255, blue: 70/255),

        // Secondary text (gentler gray)
        textSecondary: Color(red: 110/255, green: 115/255, blue: 120/255),

        // Accent (wildflower pink)
        accent: Color(red: 235/255, green: 170/255, blue: 195/255),

        // Warning (muted rose red — not aggressive)
        warning: Color(red: 200/255, green: 95/255, blue: 110/255)
    )

    
}
