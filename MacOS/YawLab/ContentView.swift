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
                    TrackView(points: circuitPoints)
                        .frame(width: 200, height: 200)
                    
                    if let selectedTime = selectedTime.time,
                       let index = sampleTimes.firstIndex(of: selectedTime) {
                        let degrees = sampleDirections[index].value * 180 / .pi
                        Image(systemName: "arrow.up")
                            .font(.system(size: 48, weight: .bold))
                            .rotationEffect(.degrees(degrees))
                    }
                }
                
                timeSeriesChartView(with: sampleSpeedPoints, yLabel: "Speed", lapTime: 86.725)
                
                timeSeriesChartView(with: sampleThrottlePoints, yLabel: "Throttle", lapTime: 86.725)
                
                timeSeriesChartView(with: sampleBrakePoints, yLabel: "Brake", lapTime: 86.725)
                
                timeSeriesChartView(with: sampleDirections, yLabel: "Direction (0 is the value calculated from the first 2 points)", lapTime: 86.725)
                
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
