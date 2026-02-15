//
//  DataView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 26..
//

import SwiftUI

struct DataView: View {
    let title: String
    let value: String?
    let unit: String
    let tag: String?
    /// Extra information shown in a popup when tapping the info button.
    let info: String?
    let dark: Bool
    @State private var showInfo = false
    @Environment(\.appTheme) private var appTheme
    
    init(title: String, value: String?, unit: String, tag: String? = nil, info: String? = nil, dark: Bool = false) {
        self.title = title
        self.value = value
        self.unit = unit
        self.tag = tag
        self.info = info
        self.dark = dark
    }

    var body: some View {
        let textPrimary = appTheme.designSystem.colors.text.primary
        let textSecondary = dark ? appTheme.designSystem.colors.text.secondary : appTheme.designSystem.colors.text.muted
        let borderColor = dark ? appTheme.designSystem.colors.background.borderSubtle : appTheme.designSystem.colors.background.borderSubtle.opacity(0.7)

        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Circle()
                    .fill(appTheme.designSystem.colors.accent.tertiary)
                    .frame(width: 8, height: 8)

                let titleWithOptionalTag = tag == nil ? title : "\(title) (\(tag!))"
                Text(titleWithOptionalTag)
                    .foregroundStyle(textSecondary)
                    .font(.subheadline)
                
                Spacer()
                
                if let info {
                    Button {
                        showInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(appTheme.designSystem.colors.accent.tertiary)
                    }
                    .buttonStyle(.plain)
                    .popover(isPresented: $showInfo, arrowEdge: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(title)
                                .font(.headline)
                                .foregroundStyle(textPrimary)
                            
                            Text(info)
                                .font(.body)
                                .foregroundStyle(textSecondary)
                        }
                        .padding(16)
                        .background(appTheme.designSystem.colors.background.panel)
                    }
                }
            }

            HStack(spacing: 6) {
                Text(value ?? "NaN")
                    .lineLimit(1)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .minimumScaleFactor(0.3)
                    .monospacedDigit()
                    .foregroundStyle(textPrimary)

                Text(unit)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(textSecondary)
                
                Spacer()
            }
        }
        .frame(width: 200)
        .padding(16)
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
        // Before: white/primary strokes. After: semantic subtle-border token.
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(borderColor)
        )
        .shadow(color: DSShadow.card, radius: 8, x: 0, y: 4)
    }
}
