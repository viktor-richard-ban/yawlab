//
//  YawLabApp.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 21..
//

import SwiftUI

@main
struct YawLabApp: App {
    var context = Context()
    
    init() {
        #if DEBUG
        context.lap = Lap(
            lapTime: 86.725,
            times: sampleTimes,
            speeds: sampleSpeeds,
            throttles: sampleThrottles,
            brakes: sampleBrakes,
            positions: samplePositionsPoints,
            wind: 180
        )
        context.run = try? JSONReader().loadFromBundle(AeroReferencePack.self, resource: "AhmedDrivAer_ReferencePack")
        context.config = context.run?.configs[0]
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(context: context)
        }
    }
}
