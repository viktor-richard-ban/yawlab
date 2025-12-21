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
    
    var body: some View {
        VStack {
            DropdownSelect(
                options: years,
                emptyText: "Select a year"
            )
            HStack {
                DropdownSelect(
                    options: events,
                    emptyText: "Select an event"
                )
                DropdownSelect(
                    options: sessions,
                    emptyText: "Select a session"
                )
            }
            DropdownSelect(
                options: drivers,
                emptyText: "Select a driver"
            )
        }
    }
}
