//
//  ChemistryDosage.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 1.11.24.
//

import SwiftUI

@Observable
class ChemistryDosage {
    /// Amount of chemestry by grams
    var amount: Double

    /// Water volume in cubic liter
    var volume: Double

    /// Value increased by amount for volume
    var increasedValue: Double

    init(amount: Double, volume: Double, increasedValue: Double) {
        self.amount = amount
        self.volume = volume
        self.increasedValue = increasedValue
    }
}
