//
//  DataView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 26..
//

import SwiftUI

struct TrackDataTile: View {
    let title: String
    let value: String
    let unit: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Circle()
                    .fill(.yellow)
                    .frame(width: 8, height: 8)

                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(value)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .monospacedDigit()

                Text(unit)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
        }
        .padding(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(.primary.opacity(0.08))
        )
    }
}
