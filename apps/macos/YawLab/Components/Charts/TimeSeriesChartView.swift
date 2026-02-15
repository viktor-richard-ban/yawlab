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

    private var minValue: Double { min(points1.map(\.value).min() ?? 0, points2.map(\.value).min() ?? 0) }
    private var maxValue: Double { max(points1.map(\.value).max() ?? 0, points2.map(\.value).max() ?? 0) }

    var body: some View {
        TimeSeriesChart(
            points1: points1,
            points2: points2,
            xLabel: xLabel,
            yLabel: yLabel,
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
    let maxTime: Double
    let minValue: Double
    let maxValue: Double
    
    @Environment(\.selectedTime) var selectedTime: TimeSelection
    @Environment(\.theme) var theme
    
    private var annotation: String {
        var text: String = ""
        if let telemetryPoint1 = points1.first(where: { $0.time == selectedTime.time}),
           let telemetryPoint2 = points2.first(where: { $0.time == selectedTime.time}) {
            text = "\(telemetryPoint1.value)\n\(telemetryPoint2.value)"
        } else if let telemetryPoint1 = points1.first(where: { $0.time == selectedTime.time}) {
            text = "\(telemetryPoint1.value)"
        }
        return text
    }

    var body: some View {
        Chart {
            LineSeries(
                points: points1,
                xLabel: xLabel,
                yLabel: yLabel,
                lineColor: theme.colors.secondaryAccent,
                seriesValue: "A"
            )
            LineSeries(
                points: points2,
                xLabel: xLabel,
                yLabel: yLabel,
                lineColor: theme.colors.textPrimary,
                seriesValue: "B"
            )
            if let selectedTime = selectedTime.time {
                RuleMark(x: .value("Time", selectedTime))
                    .foregroundStyle(theme.colors.primaryAccent)
                    .annotation {
                        Text(annotation)
                            .font(theme.typography.microLabel)
                            .foregroundStyle(theme.colors.textPrimary)
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
                        let newTime = proxy.value(atX: location.x, as: Double.self)!.closestTime(in: points1.map(\.time))
                        selectedTime.setTimeIfNotFixed(newTime)
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
