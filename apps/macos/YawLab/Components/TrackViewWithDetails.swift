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
    @Environment(\.appTheme) private var appTheme
    
    var heading: Double? {
        if let selectedTime = selectedTime.time,
           let times = context.lap?.times,
           let index = times.firstIndex(of: selectedTime),
           let lap = context.lap {
            return lap.directionTelemetryPoints[index].value * 180 / .pi
        }
        return nil
    }
    
    var isHeadingHidden: Bool {
        heading == nil
    }
    
    var body: some View {
        VStack {
            if let circuitPoints = context.lap?.positionsTelemetryPoints {
                TrackView(points: circuitPoints)
                    .frame(width: 200, height: 200)
                    .foregroundStyle(appTheme.designSystem.colors.text.primary)
            }
            
            Image(systemName: "arrow.up")
                .foregroundStyle(appTheme.designSystem.colors.text.primary)
                .font(.system(size: 48, weight: .bold))
                .rotationEffect(.degrees(heading ?? 0))
                .opacity(isHeadingHidden ? 0 : 1)

            
            let windDirection = context.lap?.wind.formatted() ?? "NaN"
            DataView(title: "Wind Direction", value: "\(windDirection)", unit: "degrees", dark: true)
                .padding(.horizontal, 8)
            let windSpeed = context.lap?.windSpeed.formatted() ?? "NaN"
            DataView(title: "Wind Speed", value: "\(windSpeed)", unit: "km/h", dark: true)
                .padding(.horizontal, 8)
        }
    }
}
