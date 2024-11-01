//
//  WaterBalanceCalculatorTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 31.10.24.
//

import Testing

@testable import ClearPoolWater

struct WaterBalanceCalculatorTests {
    let phPlusDosage = ChemistryDosage(amount: 150, volume: 10, increasedValue: 0.1)

    @Test func testCalculateValidValue() async {
        let calculator = WaterBalanceCalculator(poolVolume: 5, dosage: phPlusDosage)
        let currentPh = 7.0
        let targetPh = 7.2
        let result = try! calculator.calculate(currentValue: currentPh, targetValue: targetPh)
        #expect(result.isNearlyEqual(to: 150))
    }

    @Test func testCalculateZeroValue() async {
        let calculator = WaterBalanceCalculator(poolVolume: 5, dosage: phPlusDosage)
        let currentPh = 7.2
        let targetPh = 7.2
        let result = try! calculator.calculate(currentValue: currentPh, targetValue: targetPh)
        #expect(result.isNearlyEqual(to: 0))
    }

    @Test func testCalculateInvalidInput() async {
        let calculator = WaterBalanceCalculator(poolVolume: 5, dosage: phPlusDosage)
        let currentPh = 7.2
        let targetPh = 7.0
        #expect(throws: WaterBalanceCalculatorError.invalidInput) {
            try calculator.calculate(currentValue: currentPh, targetValue: targetPh)
        }
    }
}
