//
//  Theme+EnvironmentValues.swift
//  YawLab
//
//  Created by Viktor Bán on 2026. 02. 15..
//

import SwiftUI

private struct DSThemeKey: EnvironmentKey {
    static let defaultValue: DSTheme = .light
}

extension EnvironmentValues {
    var theme: DSTheme {
        get { self[DSThemeKey.self] }
        set { self[DSThemeKey.self] = newValue }
    }
}
