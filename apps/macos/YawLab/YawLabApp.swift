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
        let qualifyingLap = try? JSONReader().loadFromBundle(LapAPIModel.self, resource: "MockLap2025AbuDhabiQFastestLap")
        let raceLap = try? JSONReader().loadFromBundle(LapAPIModel.self, resource: "MockLap2025AbuDhabiRFastestLap")

        context.lap = raceLap?.toDomain()
        context.comparisonLap = qualifyingLap?.toDomain()
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
