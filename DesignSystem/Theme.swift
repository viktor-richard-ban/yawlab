import SwiftUI

struct DSTheme {
    let colors: DSColorPalette
    let typography: DSTypography

    static let dark = DSTheme(
        colors: DSColorPalette(
            background: Color(hex: "#0B141A"),
            panel: Color(hex: "#0F1E26"),
            card: Color(hex: "#132730"),
            border: Color(hex: "#1E3A46"),
            primaryAccent: Color(hex: "#3BA7FF"),
            secondaryAccent: Color(hex: "#A855F7"),
            tertiaryAccent: Color(hex: "#F59E0B"),
            textPrimary: Color(hex: "#E6F1F7"),
            textSecondary: Color(hex: "#9FB4BF"),
            textTertiary: Color(hex: "#5E7782")
        ),
        typography: DSTypography.default
    )
}

struct DSColorPalette {
    let background: Color
    let panel: Color
    let card: Color
    let border: Color
    let primaryAccent: Color
    let secondaryAccent: Color
    let tertiaryAccent: Color
    let textPrimary: Color
    let textSecondary: Color
    let textTertiary: Color
}

struct DSTypography {
    let appTitle: Font
    let sectionHeader: Font
    let label: Font
    let dataValue: Font
    let microLabel: Font

    static let `default` = DSTypography(
        appTitle: .system(size: 20, weight: .semibold),
        sectionHeader: .system(size: 14, weight: .semibold),
        label: .system(size: 12, weight: .medium),
        dataValue: .system(size: 20, weight: .bold, design: .rounded),
        microLabel: .system(size: 11, weight: .regular)
    )
}

private struct DSThemeKey: EnvironmentKey {
    static let defaultValue: DSTheme = .dark
}

extension EnvironmentValues {
    var theme: DSTheme {
        get { self[DSThemeKey.self] }
        set { self[DSThemeKey.self] = newValue }
    }
}
