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
    /// Extra information shown in a popup when tapping the info button.
    let info: String?
    @State private var showInfo = false
    
    init(title: String, value: String?, unit: String, info: String? = nil) {
        self.title = title
        self.value = value
        self.unit = unit
        self.info = info
        self.showInfo = showInfo
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Circle()
                    .fill(.yellow)
                    .frame(width: 8, height: 8)

                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                if let info {
                    Button {
                        showInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.yellow)
                    }
                    .buttonStyle(.plain)
                    .popover(isPresented: $showInfo, arrowEdge: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(title)
                                .font(.headline)
                            
                            Text(info)
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }
                        .padding(16)
                    }
                }
            }

            HStack(spacing: 6) {
                Text(value ?? "NaN")
                    .lineLimit(1)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .minimumScaleFactor(0.3)
                    .monospacedDigit()

                Text(unit)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(.secondary)
                
                Spacer()
            }
        }
        .frame(width: 200)
        .padding(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(.primary.opacity(0.08))
        )
    }
}
