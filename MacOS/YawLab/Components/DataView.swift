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
    
    init(title: String, value: String?, unit: String, tag: String? = nil, info: String? = nil, dark: Bool = false) {
        self.title = title
        self.value = value
        self.unit = unit
        self.tag = tag
        self.info = info
        self.dark = dark
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Circle()
                    .fill(Color(hex: "#eab308"))
                    .frame(width: 8, height: 8)

                let titleWithOptionalTag = tag == nil ? title : "\(title) (\(tag!))"
                Text(titleWithOptionalTag)
                    .foregroundStyle(dark ? .white : .black)
                    .font(.subheadline)
                
                Spacer()
                
                if let info {
                    Button {
                        showInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(Color(hex: "#eab308"))
                    }
                    .buttonStyle(.plain)
                    .popover(isPresented: $showInfo, arrowEdge: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(title)
                                .font(.headline)
                                .foregroundStyle(dark ? .white : .black)
                            
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
                    .foregroundStyle(dark ? .white : .black)

                Text(unit)
                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                    .foregroundStyle(dark ? .white : .secondary)
                
                Spacer()
            }
        }
        .frame(width: 200)
        .padding(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(dark ? .white : .primary.opacity(0.08))
        )
    }
}
