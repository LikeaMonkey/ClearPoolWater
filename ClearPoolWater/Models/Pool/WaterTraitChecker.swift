//
//  WaterChecker.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

struct WaterTraitChecker {
    enum Result {
        case normal
        case belowMinimum
        case aboveMaximum
    }

    static func check(trait: WaterTrait) -> Result {
        if trait.idealRange.contains(trait.value) {
            return .normal
        }
        return trait.value < trait.idealRange.lowerBound ? .belowMinimum : .aboveMaximum
    }
}
