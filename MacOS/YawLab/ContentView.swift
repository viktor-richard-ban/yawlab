//
//  ContentView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 21..
//

import SwiftUI

struct ContentView: View {
    @State var context = Context()
    
    var body: some View {
        NavigationSplitView {
            VStack {
                ContextSelector(context: $context)
                Spacer()
            }
        } detail: {
            VStack {
                Text("Selected context: Year: **\(context.year ?? "null")** - Event: **\(context.event ?? "null")** - Session: **\(context.session ?? "null")** - Driver: **\(context.driver ?? "null")**")
                
                timeSeriesChartView(with: sampleSpeedPoints, yLabel: "Speed", lapTime: 86.725)
                
                timeSeriesChartView(with: sampleThrottlePoints, yLabel: "Throttle", lapTime: 86.725)
                
                timeSeriesChartView(with: sampleBrakePoints, yLabel: "Brake", lapTime: 86.725)
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func timeSeriesChartView(with points: [TelemetryPoint], yLabel: String, lapTime: Double) -> some View {
        TimeSeriesChartView(points: points, yLabel: yLabel, lapTime: lapTime)
            .frame(height: 150)
            .padding(.horizontal, 16)
    }
}

#Preview {
    ContentView()
}
