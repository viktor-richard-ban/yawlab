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
    
    var yawValue: Double? {
        guard let time = selectedTime.time else { return nil }
        return context.yaw(at: time)
    }
    
    var yaw: String {
        var formattedYaw = "N/A"
        if let yawValue {
            formattedYaw = String(format: "%.6f", yawValue)
        }
        return formattedYaw
    }
    
    var cdt: String {
        guard let yawValue,
              let cd0 = context.config?.cd0,
              let k_cd_yaw2 = context.config?.yawModel.kCdYaw2  else { return "NaN" }
        let cdt = cd0 + k_cd_yaw2 * pow(yawValue, 2)
        return String(format: "%.6f", cdt)
    }
    
    var clt: String {
        guard let yawValue,
              let cl0 = context.run?.configs[0].cl0,
              let k_cl_yaw2 = context.config?.yawModel.kClYaw2 else { return "NaN" }
        let clt = cl0 + k_cl_yaw2 * pow(yawValue, 2)
        return String(format: "%.6f", clt)
    }
    
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
                DataView(title: "Yaw", value: yaw, unit: "degrees", info: "yaw = airflow direction − car direction\nNormalized to 0..180°")
                DataView(title: "CD(t)", value: cdt, unit: "", info: "CD(t) = CD0 + k_cd_yaw2 * yaw(t)²")
                DataView(title: "CL(t)", value: clt, unit: "", info: "CL(t) = CL0 + k_cl_yaw2 * yaw(t)²")
            }
        }
    }
}
