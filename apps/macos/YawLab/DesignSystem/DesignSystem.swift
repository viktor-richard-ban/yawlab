import SwiftUI

struct DesignSystem {
    let colors: DSColorPalette

    // Migration map (hardcoded -> tokenized):
    // - #0f1923 / #162128 / #0F1E26 -> colors.background.panel
    // - #132730 / #0F1E26 gradients -> colors.background.cardTop/cardBottom
    // - .white/.black/.secondary/.gray -> colors.text.primary/secondary/muted
    // - #359EFF / #eab308 / .red -> colors.accent.primary/tertiary + state.danger
    static let dark = DesignSystem(
        colors: DSColorPalette(colors: [
            .appBackground: .dsHex("0B141A"),
            .panelBackground: .dsHex("0F1E26"),
            .cardTop: .dsHex("132730"),
            .cardBottom: .dsHex("0F1E26"),
            .borderSubtle: .dsHex("3BA7FF", alpha: 0.08),

            .textPrimary: .dsHex("E6F1F7"),
            .textSecondary: .dsHex("9FB4BF"),
            .textMuted: .dsHex("5E7782"),

            .accentPrimary: .dsHex("3BA7FF"),
            .accentSecondary: .dsHex("A855F7"),
            .accentTertiary: .dsHex("F59E0B"),

            .positive: .dsHex("22C55E"),
            .warning: .dsHex("F59E0B"),
            .danger: .dsHex("EF4444")
        ])
    )

    static let light = DesignSystem(
        colors: DSColorPalette(colors: [
            .appBackground: .dsHex("F4F9FC"),
            .panelBackground: .dsHex("E8F1F6"),
            .cardTop: .dsHex("FFFFFF"),
            .cardBottom: .dsHex("F1F7FB"),
            .borderSubtle: .dsHex("0F4D72", alpha: 0.12),

            .textPrimary: .dsHex("0B141A"),
            .textSecondary: .dsHex("2D4754"),
            .textMuted: .dsHex("496775"),

            .accentPrimary: .dsHex("0E79D0"),
            .accentSecondary: .dsHex("8B3CE5"),
            .accentTertiary: .dsHex("CB7C00"),

            .positive: .dsHex("15803D"),
            .warning: .dsHex("B45309"),
            .danger: .dsHex("B91C1C")
        ])
    )
}

extension Color {
    static func dsHex(_ value: String, alpha: Double = 1.0) -> Color {
        Color(dsHex: value, alpha: alpha)
    }
}
