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

    @State private var showInfo = false
    @Environment(\.theme) var theme

    init(title: String, value: String?, unit: String, tag: String? = nil, info: String? = nil) {
        self.title = title
        self.value = value
        self.unit = unit
        self.tag = tag
        self.info = info
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Circle()
                    .fill(theme.colors.tertiaryAccent)
                    .frame(width: 8, height: 8)

                let titleWithOptionalTag = tag == nil ? title : "\(title) (\(tag!))"
                Text(titleWithOptionalTag)
                    .font(theme.typography.label)
                    .foregroundStyle(theme.colors.textPrimary)

                Spacer()

                if let info {
                    Button {
                        showInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(theme.colors.tertiaryAccent)
                    }
                    .buttonStyle(.plain)
                    .popover(isPresented: $showInfo, arrowEdge: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(title)
                                .font(theme.typography.sectionHeader)
                                .foregroundStyle(theme.colors.textPrimary)

                            Text(info)
                                .font(theme.typography.label)
                                .foregroundStyle(theme.colors.textSecondary)
                        }
                        .padding(16)
                    }
                }
            }

            HStack(spacing: 6) {
                Text(value ?? "NaN")
                    .lineLimit(1)
                    .font(theme.typography.primaryDataValue)
                    .minimumScaleFactor(0.3)
                    .monospacedDigit()
                    .foregroundStyle(theme.colors.textPrimary)

                Text(unit)
                    .font(theme.typography.microLabel)
                    .foregroundStyle(theme.colors.textSecondary)

                Spacer()
            }
        }
        .frame(width: 200)
        .padding(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(theme.colors.border)
        )
    }
}
