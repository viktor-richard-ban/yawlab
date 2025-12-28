//
//  TrackViewWithDetails.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 28..
//

import SwiftUI

struct TrackViewWithDetails: View {
    @Binding var context: Context
    @Environment(\.selectedTime) var selectedTime: TimeSelection
    
    var body: some View {
        VStack {
            if let circuitPoints = context.lap?.positionsTelemetryPoints {
                TrackView(points: circuitPoints)
                    .frame(width: 200, height: 200)
            }
            
            if let selectedTime = selectedTime.time,
               let times = context.lap?.times,
               let index = times.firstIndex(of: selectedTime),
               let lap = context.lap {
                let degrees = lap.directionTelemetryPoints[index].value * 180 / .pi
                Image(systemName: "arrow.up")
                    .font(.system(size: 48, weight: .bold))
                    .rotationEffect(.degrees(degrees))
            }
        }
    }
}
