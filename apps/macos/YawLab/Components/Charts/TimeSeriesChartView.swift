//
//  TimeSeriesChartView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 25..
//

import SwiftUI
import Charts

struct TimeSeriesChartView: View {
    let points1: [TelemetryPoint<Double>]
    let points2: [TelemetryPoint<Double>]
    let xLabel: String = "Time (s)"
    let yLabel: String
    let lapTime: Double
    let series1Label: String
    let series2Label: String

    private var minValue: Double { min(points1.map(\.value).min() ?? 0, points2.map(\.value).min() ?? 0) }
    private var maxValue: Double { max(points1.map(\.value).max() ?? 0, points2.map(\.value).max() ?? 0) }

    var body: some View {
        TimeSeriesChart(
            points1: points1,
            points2: points2,
            xLabel: xLabel,
            yLabel: yLabel,
            series1Label: series1Label,
            series2Label: series2Label,
            maxTime: lapTime,
            minValue: minValue,
            maxValue: maxValue
        )
    }
}

// MARK: - Subviews
private struct TimeSeriesChart: View {
    let points1: [TelemetryPoint<Double>]
    let points2: [TelemetryPoint<Double>]
    let xLabel: String
    let yLabel: String
    let series1Label: String
    let series2Label: String
    let maxTime: Double
    let minValue: Double
    let maxValue: Double
    
    @Environment(\.selectedTime) var selectedTime: TimeSelection
    @Environment(\.theme) var theme
    
    private var annotation1: String {
        guard let closestTime = selectedTime.time?.closestTime(in: points1.map(\.time)),
              let telemetryPoint1 = points1.first(where: { $0.time == closestTime }) else { return "" }
        return "\(series1Label): \(telemetryPoint1.value)"
    }
    private var annotation2: String? {
        guard let closestTime = selectedTime.time?.closestTime(in: points2.map(\.time)),
              let telemetryPoint2 = points2.first(where: { $0.time == closestTime }) else { return nil }
        return "\(series2Label): \(telemetryPoint2.value)"
    }

    var body: some View {
        Chart {
            LineSeries(
                points: points1,
                xLabel: xLabel,
                yLabel: yLabel,
                lineColor: theme.colors.secondaryAccent,
                seriesValue: series1Label
            )
            LineSeries(
                points: points2,
                xLabel: xLabel,
                yLabel: yLabel,
                lineColor: theme.colors.textPrimary,
                seriesValue: series2Label
            )
            if let selectedTime = selectedTime.time {
                RuleMark(x: .value("Time", selectedTime))
                    .foregroundStyle(theme.colors.primaryAccent)
                    .annotation {
                        VStack {
                            Text(annotation1)
                                .font(theme.typography.microLabel)
                                .foregroundStyle(theme.colors.textPrimary)
                            if let annotation2 {
                                Text(annotation2)
                                    .font(theme.typography.microLabel)
                                    .foregroundStyle(theme.colors.textPrimary)
                            }
                        }
                    }
            }
        }
        .chartXAxisLabel(xLabel)
        .chartYAxisLabel(yLabel)
        .chartXScale(domain: 0...maxTime)
        .chartYScale(domain: minValue...maxValue)
        .chartXAxis {
            AxisMarks { value in
                AxisValueLabel {
                    if let seconds = value.as(Double.self) {
                        Text(seconds.elapsedTime)
                    }
                }
            }
        }
        .chartOverlay { proxy in
            EmptyView()
                .onContinuousHover(perform: { phase in
                    switch phase {
                    case .active(let location):
                        if let time = proxy.value(atX: location.x, as: Double.self) {
                            let availableTimes = (points1 + points2).map(\.time)
                            let newTime = time.closestTime(in: availableTimes)
                            selectedTime.setTimeIfNotFixed(newTime)
                        }
                    case .ended:
                        selectedTime.resetIfNotFixed()
                    }
                })
        }
        .onTapGesture {
            selectedTime.isFixed.toggle()
            selectedTime.resetIfNotFixed()
        }
    }
}

private struct LineSeries: ChartContent {
    let points: [TelemetryPoint<Double>]
    let xLabel: String
    let yLabel: String
    let lineColor: Color
    let seriesValue: String

    var body: some ChartContent {
        ForEach(points) { p in
            LineMark(
                x: .value(xLabel, p.time),
                y: .value(yLabel, p.value),
                series: .value("line", seriesValue)
            )
            .foregroundStyle(lineColor)

        }
    }
}
