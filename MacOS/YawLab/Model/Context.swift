//
//  Context.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 25..
//

import Foundation

@Observable
class Context {
    var year: String?
    var event: String?
    var circuit: Circuit?
    var session: String?
    var driver: String?
    var lap: Lap?
    var run: AeroReferencePack?
}
