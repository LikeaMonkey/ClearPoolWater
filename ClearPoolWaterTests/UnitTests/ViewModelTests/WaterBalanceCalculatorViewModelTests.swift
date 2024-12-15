//
//  WaterBalanceCalculatorViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 14.11.24.
//

import Testing

@testable import ClearPoolWater

struct WaterBalanceCalculatorViewModelTests {
    @Test
    func testResult() async throws {
        let model = WaterBalanceCalculatorViewModel()

        model.calculate()

        try #require(model.result != nil)
        #expect(model.result!.isNearlyEqual(to: 300))
    }
}
