//
//  ContextSelector.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 21..
//

import SwiftUI

struct ContextSelector: View {
    let years: [String] = ["2025"]
    let events: [String] = ["Abu Dhabi"]
    let sessions: [String] = ["FP1", "FP2", "FP3", "Q", "R"]
    let drivers: [String] = ["Lando Norris"]
    @Binding var context: Context
    
    var body: some View {
        VStack {
            ActiveModelView(version: "v2.4.1", airDensity: "1.225 kg/m³", regArea: "1.42 m²")
                .padding(16)
            
            DropdownSelect(
                options: years,
                text: Binding(
                    get: { context.year ?? "Select a year" },
                    set: { context.year = $0 }
                ),
                didSelectOption: { [context] in
                    context.year = $0
                }
            )
            DropdownSelect(
                options: events,
                text: Binding(
                    get: { context.event ?? "Select an event" },
                    set: { context.event = $0 }
                ),
                didSelectOption: { [context] in
                    context.event = $0
                }
            )
            DropdownSelect(
                options: sessions,
                text: Binding(
                    get: { context.session ?? "Select a session" },
                    set: { context.session = $0 }
                ),
                didSelectOption: { [context] in
                    context.session = $0
                }
            )
            DropdownSelect(
                options: drivers,
                text: Binding(
                    get: { context.driver ?? "Select a driver" },
                    set: { context.driver = $0 }
                ),
                didSelectOption: { [context] in
                    context.driver = $0
                }
            )
        }
    }
}
