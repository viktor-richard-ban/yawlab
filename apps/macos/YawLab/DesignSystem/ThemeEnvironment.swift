import SwiftUI

struct AppTheme {
    var designSystem: DesignSystem

    static let dark = AppTheme(designSystem: .dark)
    static let light = AppTheme(designSystem: .light)
    static let `default` = AppTheme.dark
}

private struct AppThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: AppTheme = .default
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeEnvironmentKey.self] }
        set { self[AppThemeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func appTheme(_ theme: AppTheme) -> some View {
        environment(\.appTheme, theme)
    }
}
