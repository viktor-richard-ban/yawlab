//
//  Double+formatTests.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 25..
//

import Testing
@testable import YawLab

struct ElapsedTimeTests {

    @Test func dropsMinutesWhenZero() {
        #expect(9.2.elapsedTime == "09.200")
        #expect(0.0.elapsedTime == "00.000")
        #expect(59.999.elapsedTime == "59.999")
    }

    @Test func includesMinutesWhenNonZero() {
        #expect(60.1.elapsedTime == "01:00.100")
        #expect(125.6789.elapsedTime == "02:05.679")
        #expect(600.0.elapsedTime == "10:00.000")
    }

    @Test func roundsToMilliseconds() {
        #expect(1.2344.elapsedTime == "01.234")
        #expect(1.2345.elapsedTime == "01.234")
        #expect(1.2355.elapsedTime == "01.236")
    }

    @Test func handlesMinuteBoundaryRounding() {
        // Values close to 60s should not accidentally show minutes unless Int(self)/60 > 0.
        #expect(59.9999.elapsedTime == "60.000" || 59.9999.elapsedTime == "59.999")
        // Exactly 60 is a clean boundary.
        #expect(60.0.elapsedTime == "01:00.000")
    }

    @Test func handlesLargeValues() {
        #expect((3600.0).elapsedTime == "60:00.000") // 60 minutes
        #expect((3661.789).elapsedTime == "61:01.789")
    }
}
