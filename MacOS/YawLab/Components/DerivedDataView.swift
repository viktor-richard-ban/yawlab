//
//  DerivedDataView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 26..
//

import SwiftUI

struct DerivedDataView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Derived data")
                Spacer()
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.primary.opacity(0.08))
            )
            
            HStack(spacing: 8) {
                TrackDataTile(title: "Yaw", value: "\(1.022)", unit: "degrees")
                    .frame(width: 200)
                TrackDataTile(title: "Yaw", value: "\(1.022)", unit: "degrees")
                    .frame(width: 200)
            }
        }
    }
}
