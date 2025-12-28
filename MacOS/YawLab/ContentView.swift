//
//  ContentView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 21..
//

import SwiftUI

struct ContentView: View {
    @State var context: Context
    @State private var isShowingInspector = false
    @Environment(\.selectedTime) var selectedTime: TimeSelection
    
    var isContextAvailable: Bool {
        return context.lap != nil
    }
    
    var body: some View {
        NavigationSplitView {
            VStack {
                ContextSelector(context: $context)
                Spacer()
            }
        } detail: {
            if let lap = context.lap, isContextAvailable,
               let config = context.config {
                ScrollView {
                    VStack {
                        HStack {
                            DataView(title: "Config", value: config.displayName, unit: "")
                            DataView(title: "Time", value: selectedTime.time?.elapsedTime, unit: "")
                            Spacer()
                        }
                        .padding(8)
                        
                        let lapTime = lap.lapTime
                        timeSeriesChartView(with: lap.speedTelemetryPoints, yLabel: "Speed", lapTime: lapTime)
                        timeSeriesChartView(with: lap.throttleTelemetryPoints, yLabel: "Throttle", lapTime: lapTime)
                        timeSeriesChartView(with: lap.brakeTelemetryPoints, yLabel: "Brake", lapTime: lapTime)
                        
                        DerivedDataView(context: $context)
                            .padding(.top, 32)
                            .padding(.horizontal, 16)
                    }
                }
            } else {
                contentUnavailableView()
            }
        }
        .toolbar {
            if isContextAvailable {
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
    
    @ViewBuilder
    private func contentUnavailableView() -> some View {
        ContentUnavailableView(
            "Select data to begin analysis",
            systemImage: "chart.line.uptrend.xyaxis",
            description: Text("Select an event, session, and lap to load telemetry and aerodynamic analysis.")
        )
    }
}
