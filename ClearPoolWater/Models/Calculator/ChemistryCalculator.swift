//
//  ChemistryCalculator.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 31.10.24.
//

import SwiftUI

enum WaterBalanceCalculatorError: Error {
    case invalidInput
}

struct WaterBalanceCalculator {
    /// Pool water volume in cubic liter
    let poolVolume: Double
    let dosage: ChemistryDosage

    func calculate(currentValue: Double, targetValue: Double) throws -> Double {
        guard targetValue >= currentValue else {
            throw WaterBalanceCalculatorError.invalidInput
        }

        let diff = targetValue - currentValue
        let valueMultiplier = diff / dosage.increasedValue
        let volumeMultiplier = poolVolume / dosage.volume
        let result = dosage.amount * valueMultiplier * volumeMultiplier

        return result
    }
}
