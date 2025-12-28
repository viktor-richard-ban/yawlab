//
//  ContentView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 21..
//

import SwiftUI

struct ContentView: View {
    @State var context = Context()
    @State var isShowingInspector = false
    @Environment(\.selectedTime) var selectedTime: TimeSelection
    
    init() {
        #if DEBUG
        self.context.lap = Lap(
            lapTime: 86.725,
            times: sampleTimes,
            speeds: sampleSpeeds,
            throttles: sampleThrottles,
            brakes: sampleBrakes,
            positions: samplePositionsPoints,
            wind: 180
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
            ScrollView {
                VStack {
                    let lapTime = context.lap?.lapTime ?? 0.0
                    timeSeriesChartView(with: context.lap?.speedTelemetryPoints ?? [], yLabel: "Speed", lapTime: lapTime)
                    
                    timeSeriesChartView(with: context.lap?.throttleTelemetryPoints ?? [], yLabel: "Throttle", lapTime: lapTime)
                    
                    timeSeriesChartView(with: context.lap?.brakeTelemetryPoints ?? [], yLabel: "Brake", lapTime: lapTime)
                    
                    timeSeriesChartView(with: context.lap?.directionTelemetryPoints ?? [], yLabel: "Direction (0 is the value calculated from the first 2 points)", lapTime: lapTime)
                    
                    DerivedDataView(context: $context)
                        .padding(.top, 32)
                        .padding(.horizontal, 16)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isShowingInspector.toggle()
                } label: {
                    HStack {
                        Image(systemName: "chart.bar")
                        Text("Track View")
                    }
                }
                .keyboardShortcut("T")
            }
        }
        .inspector(isPresented: $isShowingInspector, content: {
            VStack {
                TrackViewWithDetails(context: $context)
                Spacer()
            }
        })
        .environment(selectedTime)
    }
    
    @ViewBuilder
    private func timeSeriesChartView(with points: [TelemetryPoint<Double>], yLabel: String, lapTime: Double) -> some View {
        TimeSeriesChartView(points: points, yLabel: yLabel, lapTime: lapTime)
            .frame(height: 150)
            .padding(.horizontal, 16)
    }
}
