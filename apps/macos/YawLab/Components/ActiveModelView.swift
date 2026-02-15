//
//  ActiveModelView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 29..
//

import SwiftUI

struct ActiveModelView: View {
    let version: String
    let airDensity: String // "1.225 kg/m³"
    let regArea: String // "1.42 m²"

    @Environment(\.theme) var theme

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text("ACTIVE MODEL")
                    .font(theme.typography.sectionHeader)
                    .foregroundStyle(theme.colors.primaryAccent)
                Spacer()
                Text(version)
                    .font(theme.typography.label)
                    .padding(4)
                    .foregroundStyle(theme.colors.primaryAccent)
                    .background(theme.colors.card)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                    )
            }

            HStack {
                VStack(alignment: .leading) {
                    Text("Air Denisity")
                        .font(theme.typography.label)
                        .foregroundStyle(theme.colors.textSecondary)
                    Text(airDensity)
                        .font(theme.typography.secondaryDataValue)
                        .foregroundStyle(theme.colors.textPrimary)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Reg Area")
                        .font(theme.typography.label)
                        .foregroundStyle(theme.colors.textSecondary)
                    Text(regArea)
                        .font(theme.typography.secondaryDataValue)
                        .foregroundStyle(theme.colors.textPrimary)
                }
                Spacer()
            }
        }
        .padding()
        .background(theme.colors.panel)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(theme.colors.border, lineWidth: 2)
        )
    }
}

#Preview {
    ActiveModelView(version: "v2.4.1", airDensity: "1.225 kg/m³", regArea: "1.42 m²")
        .padding(16)
}
