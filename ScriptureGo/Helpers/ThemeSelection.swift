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
    

}
