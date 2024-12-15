//
//  ColorEvaluatorTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 4.11.24.
//

import Testing

@testable import ClearPoolWater

struct ColorEvaluatorTests {
    @Test func testNilValue() {
        let color = ColorEvaluator.evaluateColor(for: nil, in: 5.0...10.0)
        #expect(color == .gray)
    }

    @Test func testValueInIdealRange() {
        let color = ColorEvaluator.evaluateColor(for: 7.0, in: 5.0...10.0)
        #expect(color == .green)
    }

    @Test func testValueNearLowerBound() {
        let color = ColorEvaluator.evaluateColor(for: 4.0, in: 5.0...10.0)
        #expect(color == .yellow)
    }

    @Test func testValueNearUpperBound() {
        let color = ColorEvaluator.evaluateColor(for: 11.0, in: 5.0...10.0)
        #expect(color == .yellow)
    }

    @Test func testValueBelowLowerThreshold() {
        let color = ColorEvaluator.evaluateColor(for: 3.0, in: 5.0...10.0)
        #expect(color == .red)
    }

    @Test func testValueAboveUpperThreshold() {
        let color = ColorEvaluator.evaluateColor(for: 12.0, in: 5.0...10.0)
        #expect(color == .red)
    }
}
