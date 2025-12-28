//
//  Environment+TimeSelection.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 25..
//

import SwiftUI

@Observable
class TimeSelection {
    var time: Double? // in seconds
}

struct TimeSelectionKey: EnvironmentKey {
    static let defaultValue: TimeSelection = TimeSelection()

}

extension EnvironmentValues {
    var selectedTime: TimeSelection {
        get { self[TimeSelectionKey.self] }
        set { self[TimeSelectionKey.self] = newValue }
    }
}
