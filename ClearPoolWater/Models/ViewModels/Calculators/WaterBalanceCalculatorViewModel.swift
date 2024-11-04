//
//  WaterBalanceCalculatorViewModel.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 1.11.24.
//

import SwiftUI

@Observable
final class WaterBalanceCalculatorViewModel {
    var poolVolume = 10.0

    var currentValue = 7.0
    var targetValue = 7.2

    var dosage = ChemistryDosage(amount: 150, volume: 10, increasedValue: 0.1)

    var result: Double?

    func calculate() {
        let calculator = WaterBalanceCalculator(
            poolVolume: poolVolume,
            dosage: dosage
        )

        do {
            let amount = try calculator.calculate(
                currentValue: currentValue,
                targetValue: targetValue
            )

            result = amount
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
}
