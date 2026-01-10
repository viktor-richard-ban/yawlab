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
    
    var q: String {
        guard let time = selectedTime.time,
              let rho = context.run?.defaults.rho,
              let speed = context.lap?.speedTelemetryPoints.first(where: { $0.time == time })?.value else { return "NaN" }
        let qValue = 0.5 * rho * pow(speed.kphToMps() ,2)
        return String(format: "%.6f", qValue)
    }
    
    var dragForce: String {
        guard let time = selectedTime.time,
              let rho = context.run?.defaults.rho,
              let speed = context.lap?.speedTelemetryPoints.first(where: { $0.time == time })?.value,
              let yawValue,
              let cd0 = context.config?.cd0,
              let k_cd_yaw2 = context.config?.yawModel.kCdYaw2,
              let areaRef = context.run?.defaults.areaRef else { return "NaN" }
        let qValue = 0.5 * rho * pow(speed.kphToMps() ,2)
        let cdt = cd0 + k_cd_yaw2 * pow(yawValue, 2)
        let drag = qValue * areaRef * cdt
        return String(format: "%.6f", drag)
    }
    
    var downforce: String {
        guard let time = selectedTime.time,
              let rho = context.run?.defaults.rho,
              let speed = context.lap?.speedTelemetryPoints.first(where: { $0.time == time })?.value,
              let yawValue,
              let cl0 = context.config?.cl0,
              let k_cl_yaw2 = context.config?.yawModel.kClYaw2,
              let areaRef = context.run?.defaults.areaRef else { return "NaN" }
        let qValue = 0.5 * rho * pow(speed.kphToMps() ,2)
        let clt = cl0 + k_cl_yaw2 * pow(yawValue, 2)
        let downforce = qValue * areaRef * clt
        return String(format: "%.6f", downforce)
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
            
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 230, maximum: 230), spacing: 8)],
                alignment: .leading,
                spacing: 8
            ) {
                DataView(title: "Yaw", value: yaw, unit: "degrees", info: "yaw = atan2(V_rel,y , V_rel,x) − heading")
                DataView(title: "CD(t)", value: cdt, unit: "", info: "CD(t) = CD0 + k_cd_yaw2 * yaw(t)²")
                DataView(title: "CL(t)", value: clt, unit: "", info: "CL(t) = CL0 + k_cl_yaw2 * yaw(t)²")
                DataView(title: "Dynamic pressure - q", value: q, unit: "Pa (N/m²)", info: "q = 0.5 * rho * speedMps²")
                DataView(title: "Drag force - Drag(t)", value: dragForce, unit: "N", info: "Drag(t) = q(t) * A_ref * CD(t)")
                DataView(title: "Downforce(t)", value: downforce, unit: "N", info: "Downforce(t) = q(t) * A_ref * CL(t)")
            }
            .padding()
        }
    }
}
