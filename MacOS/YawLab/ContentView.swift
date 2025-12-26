//
//  ContentView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 21..
//

import SwiftUI

struct ContentView: View {
    @State var context = Context()
    @Environment(\.selectedTime) var selectedTime: TimeSelection
    
    init() {
        #if DEBUG
        self.context.lap = Lap(
            lapTime: 86.725,
            times: sampleTimes,
            speeds: sampleSpeeds,
            throttles: sampleThrottles,
            brakes: sampleBrakes,
            positions: samplePositionsPoints
        )
        #endif
    }
    
    var body: some View {
        NavigationSplitView {
            VStack {
                ContextSelector(context: $context)
                Spacer()
            }
        } detail: {
            VStack {
                Text("Selected context: Year: **\(context.year ?? "null")** - Event: **\(context.event ?? "null")** - Session: **\(context.session ?? "null")** - Driver: **\(context.driver ?? "null")**")
                
                HStack {
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
                
                let lapTime = context.lap?.lapTime ?? 0.0
                timeSeriesChartView(with: context.lap?.speedTelemetryPoints ?? [], yLabel: "Speed", lapTime: lapTime)
                
                timeSeriesChartView(with: context.lap?.throttleTelemetryPoints ?? [], yLabel: "Throttle", lapTime: lapTime)
                
                timeSeriesChartView(with: context.lap?.brakeTelemetryPoints ?? [], yLabel: "Brake", lapTime: lapTime)
                
                timeSeriesChartView(with: context.lap?.directionTelemetryPoints ?? [], yLabel: "Direction (0 is the value calculated from the first 2 points)", lapTime: lapTime)
                
                Spacer()
            }
        }
        .environment(selectedTime)
    }
    
    @ViewBuilder
    private func timeSeriesChartView(with points: [TelemetryPoint<Double>], yLabel: String, lapTime: Double) -> some View {
        TimeSeriesChartView(points: points, yLabel: yLabel, lapTime: lapTime)
            .frame(height: 150)
            .padding(.horizontal, 16)
    }
}

#Preview {
    ContentView()
}
