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
        let dataLoader = LapMockDataLoader()
        let qualifyingLap = try? dataLoader.loadLap(resource: "MockLap2025AbuDhabiQFastestLap")
        let raceLap = try? dataLoader.loadLap(resource: "MockLap2025AbuDhabiRFastestLap")

        context.lap = raceLap
        context.comparisonLap = qualifyingLap
        context.lapLabel = "LEC R"
        context.comparisonLapLabel = "VER Q"

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
