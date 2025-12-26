//
//  TrackView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 26..
//

import SwiftUI
import CoreGraphics

struct TrackView: View {
    let points: [TelemetryPoint<CGPoint>]
    var pointValues: [CGPoint] {
        points.map { $0.value }
    }
    
    @Environment(\.selectedTime) var selectedTime: TimeSelection

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Track
                makeTrackPath(points: pointValues, in: CGRect(origin: .zero, size: geo.size))
                    .stroke(.primary, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                
                if let selectedTime = selectedTime.time,
                   let telemetryPoint = points.first(where: { $0.time == selectedTime }) {
                    // Car
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                        .position(
                            mapPoint(
                                telemetryPoint.value,
                                points: pointValues,
                                in: CGRect(origin: .zero, size: geo.size)
                            )
                        )
                }
            }
        }
    }
    
    /// Builds a Path that fits the given world-space points into `rect`.
    func makeTrackPath(points: [CGPoint], in rect: CGRect, close: Bool = true) -> Path {
        guard points.count >= 2 else { return Path() }
        
        // World bounds
        var minX = points[0].x, maxX = points[0].x
        var minY = points[0].y, maxY = points[0].y
        for p in points {
            minX = min(minX, p.x); maxX = max(maxX, p.x)
            minY = min(minY, p.y); maxY = max(maxY, p.y)
        }
        
        let worldW = max(maxX - minX, 0.0001)
        let worldH = max(maxY - minY, 0.0001)
        
        let scale = min(rect.width / worldW, rect.height / worldH)
        
        let scaledW = worldW * scale
        let scaledH = worldH * scale
        let offsetX = rect.midX - scaledW / 2
        let offsetY = rect.midY - scaledH / 2
        
        func map(_ p: CGPoint) -> CGPoint {
            CGPoint(
                x: (p.x - minX) * scale + offsetX,
                y: (maxY - p.y) * scale + offsetY
            )
        }
        
        var path = Path()
        path.move(to: map(points[0]))
        for p in points.dropFirst() {
            path.addLine(to: map(p))
        }
        if close {
            path.closeSubpath()
        }
        return path
    }
    
    /// Maps a single world point using the same transform
    func mapPoint(_ p: CGPoint, points: [CGPoint], in rect: CGRect) -> CGPoint {
        var minX = points[0].x, maxX = points[0].x
        var minY = points[0].y, maxY = points[0].y
        for pt in points {
            minX = min(minX, pt.x); maxX = max(maxX, pt.x)
            minY = min(minY, pt.y); maxY = max(maxY, pt.y)
        }
        
        let scale = min(
            rect.width / max(maxX - minX, 0.0001),
            rect.height / max(maxY - minY, 0.0001)
        )
        
        let offsetX = rect.midX - (maxX - minX) * scale / 2
        let offsetY = rect.midY - (maxY - minY) * scale / 2
        
        return CGPoint(
            x: (p.x - minX) * scale + offsetX,
            y: (maxY - p.y) * scale + offsetY
        )
    }
}
