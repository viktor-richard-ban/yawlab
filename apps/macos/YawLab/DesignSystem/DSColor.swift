import SwiftUI

enum DSSemanticColor: CaseIterable {
    case appBackground
    case panelBackground
    case cardTop
    case cardBottom
    case borderSubtle

    case textPrimary
    case textSecondary
    case textMuted

    case accentPrimary
    case accentSecondary
    case accentTertiary

    case positive
    case warning
    case danger
}

struct DSColorPalette {
    private let colors: [DSSemanticColor: Color]

    init(colors: [DSSemanticColor: Color]) {
        self.colors = colors
    }

    subscript(_ token: DSSemanticColor) -> Color {
        colors[token, default: .clear]
    }

    var background: DSBackgroundColors {
        DSBackgroundColors(palette: self)
    }

    var text: DSTextColors {
        DSTextColors(palette: self)
    }

    var accent: DSAccentColors {
        DSAccentColors(palette: self)
    }

    var state: DSStateColors {
        DSStateColors(palette: self)
    }

    struct DSBackgroundColors {
        fileprivate let palette: DSColorPalette
        var app: Color { palette[.appBackground] }
        var panel: Color { palette[.panelBackground] }
        var cardTop: Color { palette[.cardTop] }
        var cardBottom: Color { palette[.cardBottom] }
        var borderSubtle: Color { palette[.borderSubtle] }
    }

    struct DSTextColors {
        fileprivate let palette: DSColorPalette
        var primary: Color { palette[.textPrimary] }
        var secondary: Color { palette[.textSecondary] }
        var muted: Color { palette[.textMuted] }
    }

    struct DSAccentColors {
        fileprivate let palette: DSColorPalette
        var primary: Color { palette[.accentPrimary] }
        var secondary: Color { palette[.accentSecondary] }
        var tertiary: Color { palette[.accentTertiary] }
    }

    struct DSStateColors {
        fileprivate let palette: DSColorPalette
        var positive: Color { palette[.positive] }
        var warning: Color { palette[.warning] }
        var danger: Color { palette[.danger] }
    }
}

extension Color {
    /// Code fallback when an Asset Catalog color is not available.
    init(dsHex hex: String, alpha: Double = 1.0) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB
            (a, r, g, b) = (
                255,
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17
            )
        case 6: // RGB
            (a, r, g, b) = (
                255,
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        case 8: // ARGB
            (a, r, g, b) = (
                int >> 24,
                int >> 16 & 0xFF,
                int >> 8 & 0xFF,
                int & 0xFF
            )
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: (Double(a) / 255) * alpha
        )
    }
}
