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
    @Environment(\.theme) var theme
    
    var isContextAvailable: Bool {
        return context.lap != nil
    }
    
    var body: some View {
        NavigationSplitView {
            VStack {
                if let run = context.run {
                    let airDensity = "\(run.defaults.rho) \(run.units.rho)"
                    let regArea = "\(run.defaults.areaRef) \(run.units.area)"
                    ActiveModelView(version: run.version, airDensity: airDensity, regArea: regArea)
                        .padding(16)
                }
                // TODO: - Add ContextSelector
                Spacer()
            }
            .background(theme.colors.background)
            .foregroundStyle(theme.colors.textPrimary)
        } detail: {
            if let lap = context.lap, isContextAvailable,
               let config = context.config {
                ScrollView {
                    VStack {
                        HStack {
                            DataView(title: "Config", value: config.displayName, unit: "")
                            DataView(title: "Time", value: selectedTime.time?.elapsedTime, unit: "", tag: selectedTime.isFixed ? "Fixed" : nil)
                            Spacer()
                        }
                        .padding(8)
                        
                        let lapTime = max(lap.lapTime, context.comparisonLap?.lapTime ?? lap.lapTime)
                        timeSeriesChartView(
                            primaryPoints: lap.speedTelemetryPoints,
                            secondaryPoints: context.comparisonLap?.speedTelemetryPoints ?? [],
                            yLabel: "Speed",
                            lapTime: lapTime
                        )
                        timeSeriesChartView(
                            primaryPoints: lap.throttleTelemetryPoints,
                            secondaryPoints: context.comparisonLap?.throttleTelemetryPoints ?? [],
                            yLabel: "Throttle",
                            lapTime: lapTime
                        )
                        timeSeriesChartView(
                            primaryPoints: lap.brakeTelemetryPoints,
                            secondaryPoints: context.comparisonLap?.brakeTelemetryPoints ?? [],
                            yLabel: "Brake",
                            lapTime: lapTime
                        )
                        
                        DerivedDataView(context: $context)
                            .padding(.top, 32)
                            .padding(.horizontal, 16)
                    }
                }
                .padding(.vertical, 8)
                .background(theme.colors.background)
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
        .toolbarBackground(theme.colors.primaryAccent)
        .toolbarColorScheme(.light)
        .inspector(isPresented: $isShowingInspector, content: {
            HStack {
                Spacer()
                VStack {
                    TrackViewWithDetails(context: $context)
                    Spacer()
                }
                Spacer()
            }
            .padding(.vertical, 16)
            .background(theme.colors.background)
        })
        .environment(selectedTime)
    }
    
    @ViewBuilder
    private func timeSeriesChartView(
        primaryPoints: [TelemetryPoint<Double>],
        secondaryPoints: [TelemetryPoint<Double>],
        yLabel: String,
        lapTime: Double
    ) -> some View {
        TimeSeriesChartView(
            points1: primaryPoints,
            points2: secondaryPoints,
            series1Label: context.lapLabel ?? "Lap A",
            series2Label: context.comparisonLapLabel ?? "Lap B",
            yLabel: yLabel,
            lapTime: lapTime
        )
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
