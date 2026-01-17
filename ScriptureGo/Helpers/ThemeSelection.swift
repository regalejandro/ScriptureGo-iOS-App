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

    @AppStorage("selectedTheme")
    private var selectedTheme: String = AppTheme.parchment.rawValue

    @Published var current: Theme

    init() {
        let storedTheme =
            UserDefaults.standard.string(forKey: "selectedTheme")
            ?? AppTheme.parchment.rawValue

        let appTheme = AppTheme(rawValue: storedTheme) ?? .parchment
        self.current = appTheme.theme
    }

    func setTheme(_ theme: AppTheme) {
        selectedTheme = theme.rawValue
        current = theme.theme
    }
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

enum AppTheme: String, CaseIterable {
    case parchment
    case meadow

    var theme: Theme {
        switch self {
        case .parchment:
            return Theme(
                primary: Color(red: 135/255, green: 90/255, blue: 60/255),
                secondary: Color(red: 220/255, green: 205/255, blue: 190/255),
                background: Color(red: 245/255, green: 235/255, blue: 220/255),
                textPrimary: Color(red: 60/255, green: 55/255, blue: 50/255),
                textSecondary: Color(red: 120/255, green: 115/255, blue: 110/255),
                accent: Color(red: 110/255, green: 125/255, blue: 90/255),
                warning: Color(red: 165/255, green: 75/255, blue: 60/255)
            )

        case .meadow:
            return Theme(
                primary: Color(red: 155/255, green: 195/255, blue: 225/255),
                secondary: Color(red: 195/255, green: 220/255, blue: 200/255),
                background: Color(red: 250/255, green: 246/255, blue: 240/255),
                textPrimary: Color(red: 60/255, green: 65/255, blue: 70/255),
                textSecondary: Color(red: 110/255, green: 115/255, blue: 120/255),
                accent: Color(red: 235/255, green: 170/255, blue: 195/255),
                warning: Color(red: 200/255, green: 95/255, blue: 110/255)
            )
        }
    }
}

