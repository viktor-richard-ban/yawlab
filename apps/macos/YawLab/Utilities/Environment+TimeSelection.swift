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
    var isFixed: Bool = false
    
    func setTimeIfNotFixed(_ time: Double?) {
        if !isFixed {
            self.time = time
        }
    }
    
    func resetIfNotFixed() {
        if !isFixed {
            time = nil
        }
    }
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
