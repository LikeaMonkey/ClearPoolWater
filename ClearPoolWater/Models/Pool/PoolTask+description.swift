//
//  PoolTask+description.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 4.11.24.
//

import SwiftUI

extension PoolTask.Code {
    var description: LocalizedStringKey {
        switch self {
        case .lowPh(let diff):
            return "Low pH by \(diff.formatted())"
        case .highPh(let diff):
            return "High pH by \(diff.formatted())"
        case .lowChlorine(let diff):
            return "Low Chlorine by \(diff.formatted())"
        case .highChlorine(let diff):
            return "High Chlorine by \(diff.formatted())"
        case .lowAlkalinity(let diff):
            return "Low Alkalinity by \(diff.formatted())"
        case .highAlkalinity(let diff):
            return "High Alkalinity by \(diff.formatted())"
        case .lowTemperature(let diff):
            return "Low Temperature by \(diff.formatted())°C"
        case .highTemperature(let diff):
            return "High Temperature by \(diff.formatted())°C"
        case .skim:
            return "Skim the pool surface"
        case .vacuum:
            return "Vacuum the pool"
        case .brush:
            return "Brush the pool walls"
        case .emptyBaskets:
            return "Empty the pool baskets"
        case .testWater:
            return "Test the pool water chemistry"
        case .cleanFilter:
            return "Clean the pool filter"
        case .runPump:
            return "Run the pool pump"
        case .inspect:
            return "Inspect the pool equipment"
        }
    }
}
