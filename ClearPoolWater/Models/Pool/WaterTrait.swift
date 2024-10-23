//
//  WaterTrait.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

enum WaterTraitType {
    case ph, alkalinity, chlorine, temperature
}

struct WaterTrait {
    let type: WaterTraitType
    var value: Double
    let idealRange: ClosedRange<Double>
}

struct WaterTraitFactory {
    static func create(type: WaterTraitType, value: Double) -> WaterTrait {
        switch type {
        case .ph:
            return WaterTrait(type: .ph, value: value, idealRange: 7.2...7.6)
        case .alkalinity:
            return WaterTrait(type: .alkalinity, value: value, idealRange: 80.0...120.0)
        case .chlorine:
            return WaterTrait(type: .chlorine, value: value, idealRange: 1.0...3.0)
        case .temperature:
            return WaterTrait(type: .temperature, value: value, idealRange: 25.0...28.0)
        }
    }
}
