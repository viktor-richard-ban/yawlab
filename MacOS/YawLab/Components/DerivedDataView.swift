//
//  DerivedDataView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 26..
//

import SwiftUI

struct DerivedDataView: View {
    @Binding var context: Context
    @Environment(\.selectedTime) var selectedTime: TimeSelection
    
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
                let yaw = context.lap?.yawTelemetryPoints.first(where: { $0.time == selectedTime.time })?.value ?? 0.0
                DataView(title: "Yaw", value: String(format: "%.2f", yaw), unit: "degrees", info: "yaw = airflow direction − car direction\nNormalized to 0..180°")
            }
        }
    }
}
