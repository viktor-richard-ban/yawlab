//
//  TimeSeriesChartView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 25..
//

import SwiftUI
import Charts

struct TimeSeriesChartView: View {
    let points: [TelemetryPoint<Double>]
    let xLabel: String = "Time (s)"
    let yLabel: String
    let lapTime: Double

    private var minValue: Double { points.map(\.value).min() ?? 0 }
    private var maxValue: Double { points.map(\.value).max() ?? 0 }
    private var maxTime: Double { max(points.map(\.time).max() ?? lapTime, lapTime) }

    var body: some View {
        TimeSeriesChart(
            points: points,
            xLabel: xLabel,
            yLabel: yLabel,
            maxTime: maxTime,
            minValue: minValue,
            maxValue: maxValue
        )
    }
}

// MARK: - Subviews
private struct TimeSeriesChart: View {
    let points: [TelemetryPoint<Double>]
    let xLabel: String
    let yLabel: String
    let maxTime: Double
    let minValue: Double
    let maxValue: Double
    
    @Environment(\.selectedTime) var selectedTime: TimeSelection

    var body: some View {
        Chart {
            LineSeries(
                points: points,
                xLabel: xLabel,
                yLabel: yLabel
            )
            if let selectedTime = selectedTime.time {
                RuleMark(x: .value("Time", selectedTime))
                    .foregroundStyle(.red)
                    .annotation {
                        if let telemetryPoint = points.first(where: { $0.time == selectedTime}) {
                            Text("\(telemetryPoint.value)")
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
                        selectedTime.time = proxy.value(atX: location.x, as: Double.self)!.closestTime(in: points.map(\.time))
                    case .ended:
                        selectedTime.time = nil
                    }
                })
        }
    }
}

private struct LineSeries: ChartContent {
    let points: [TelemetryPoint<Double>]
    let xLabel: String
    let yLabel: String

    var body: some ChartContent {
        ForEach(points) { p in
            LineMark(
                x: .value(xLabel, p.time),
                y: .value(yLabel, p.value)
            )
        }
    }
}
