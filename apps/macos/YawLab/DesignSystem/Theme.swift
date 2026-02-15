import SwiftUI

struct DSTheme {
    let colors: DSColorPalette
    let typography: DSTypography

    static let dark = DSTheme(
        colors: DSColorPalette(
            background: Color(hex: "#0B1220"),
            panel: Color(hex: "#111827"),
            card: Color(hex: "#1B2A41"),
            border: Color(hex: "#2A3B55"),
            primaryAccent: Color(hex: "#4DA3FF"),
            secondaryAccent: Color(hex: "#7C8CFF"),
            tertiaryAccent: Color(hex: "#2EE6D6"),
            textPrimary: Color(hex: "#E6EDF6"),
            textSecondary: Color(hex: "#9FB3C8"),
            textTertiary: Color(hex: "#6B7F95")
        ),
        typography: DSTypography.default
    )
    
    static let light = DSTheme(
        colors: DSColorPalette(
            background: Color(hex: "#F7FAFF"),
            panel: Color(hex: "#EEF3FB"),
            card: Color(hex: "#FFFFFF"),
            border: Color(hex: "#D6E0EE"),
            
            primaryAccent: Color(hex: "#1E7BFF"),
            secondaryAccent: Color(hex: "#5B6CFF"),
            tertiaryAccent: Color(hex: "#00BFB2"),
            
            textPrimary: Color(hex: "#0B1220"),
            textSecondary: Color(hex: "#344B63"),
            textTertiary: Color(hex: "#5F768E")
        ),
        typography: DSTypography.default
    )
}

struct DSColorPalette {
    // Foundations
    let background: Color       // App background
    let panel: Color            // Panels / sidebars
    let card: Color             // Cards / elevated surfaces
    let border: Color           // Dividers / strokes
    // Accents
    let primaryAccent: Color    // Primary (focus/brand)
    let secondaryAccent: Color  // Secondary (premium/alt series)
    let tertiaryAccent: Color   // Tertiary (highlight/realtime)
    // Text
    let textPrimary: Color
    let textSecondary: Color
    let textTertiary: Color
}

struct DSTypography {
    let appTitle: Font
    let sectionHeader: Font
    let label: Font
    let primaryDataValue: Font
    let secondaryDataValue: Font
    let microLabel: Font

    static let `default` = DSTypography(
        appTitle: .system(size: 20, weight: .semibold),
        sectionHeader: .system(size: 14, weight: .semibold),
        label: .system(size: 12, weight: .medium),
        primaryDataValue: .system(size: 20, weight: .bold, design: .rounded),
        secondaryDataValue: .system(size: 16, weight: .bold, design: .rounded),
        microLabel: .system(size: 11, weight: .regular)
    )
}
