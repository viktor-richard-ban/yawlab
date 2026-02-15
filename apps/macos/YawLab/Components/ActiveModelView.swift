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
    @Environment(\.appTheme) private var appTheme
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text("ACTIVE MODEL")
                    .fontWeight(.bold)
                    .foregroundStyle(appTheme.designSystem.colors.accent.primary)
                Spacer()
                Text(version)
                    .padding(4)
                    .foregroundStyle(appTheme.designSystem.colors.accent.primary)
                    .background(appTheme.designSystem.colors.background.panel)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                    )
                    
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Air Denisity")
                        .foregroundStyle(appTheme.designSystem.colors.text.muted)
                    Text(airDensity)
                        .foregroundStyle(appTheme.designSystem.colors.text.primary)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Reg Area")
                        .foregroundStyle(appTheme.designSystem.colors.text.muted)
                    Text(regArea)
                        .foregroundStyle(appTheme.designSystem.colors.text.primary)
                }
                Spacer()
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [
                    appTheme.designSystem.colors.background.cardTop,
                    appTheme.designSystem.colors.background.cardBottom
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(appTheme.designSystem.colors.background.borderSubtle, lineWidth: 2)
        )
        .shadow(color: DSShadow.raised, radius: 10, x: 0, y: 6)
    }
}

#Preview {
    ActiveModelView(version: "v2.4.1", airDensity: "1.225 kg/m³", regArea: "1.42 m²")
        .padding(16)
}
