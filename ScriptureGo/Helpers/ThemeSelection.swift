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

    @AppStorage("selectedTheme") private var selectedThemeRaw: String = AppTheme.parchment.rawValue

    @Published private(set) var current: Theme


    init() {
        let raw = UserDefaults.standard.string(forKey: "selectedTheme") ?? AppTheme.parchment.rawValue
        let baseTheme = AppTheme(rawValue: raw) ?? .parchment
        self.current = baseTheme.light.theme
    }


    func setBaseTheme(_ theme: AppTheme, preference: ThemePreference, systemScheme: ColorScheme) {
        selectedThemeRaw = theme.rawValue
        applyThemePreference(preference, systemScheme: systemScheme)
    }

    func applyThemePreference(_ preference: ThemePreference, systemScheme: ColorScheme) {
        let baseTheme =
            AppTheme(rawValue: selectedThemeRaw) ?? .parchment

        let variant: AppThemeVariant

        switch preference {
        case .system:
            variant = systemScheme == .dark
                ? baseTheme.dark
                : baseTheme.light

        case .light:
            variant = baseTheme.light

        case .dark:
            variant = baseTheme.dark
        }

        current = variant.theme
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

    // Light variant
    var light: AppThemeVariant {
        switch self {
        case .parchment: return .parchment
        case .meadow: return .meadow
        }
    }

    // Dark variant
    var dark: AppThemeVariant {
        switch self {
        case .parchment: return .parchmentDark
        case .meadow: return .meadowDark
        }
    }
}

enum AppThemeVariant {
    case parchment
    case parchmentDark
    case meadow
    case meadowDark

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
        case .parchmentDark:
            return Theme(
                primary: Color(red: 175/255, green: 130/255, blue: 90/255),
                secondary: Color(red: 60/255, green: 50/255, blue: 42/255),
                background: Color(red: 28/255, green: 24/255, blue: 20/255),
                textPrimary: Color(red: 235/255, green: 228/255, blue: 215/255),
                textSecondary: Color(red: 185/255, green: 175/255, blue: 165/255),
                accent: Color(red: 150/255, green: 165/255, blue: 120/255),
                warning: Color(red: 190/255, green: 90/255, blue: 70/255)
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
        case .meadowDark:
            return Theme(
                primary: Color(red: 115/255, green: 145/255, blue: 180/255),
                secondary: Color(red: 55/255, green: 70/255, blue: 60/255),
                background: Color(red: 20/255, green: 26/255, blue: 24/255),
                textPrimary: Color(red: 225/255, green: 232/255, blue: 235/255),
                textSecondary: Color(red: 170/255, green: 178/255, blue: 180/255),
                accent: Color(red: 205/255, green: 145/255, blue: 170/255),
                warning: Color(red: 185/255, green: 85/255, blue: 100/255)
            )
        }
    }
}


