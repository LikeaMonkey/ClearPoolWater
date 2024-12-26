//
//  TemperatureUnit.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.12.24.
//
import Foundation

enum TemperatureUnit: String, CaseIterable, Identifiable {
    case celsius, fahrenheit, kelvin

    var id: String { rawValue }

    var unit: UnitTemperature {
        switch self {
        case .celsius: .celsius
        case .fahrenheit: .fahrenheit
        case .kelvin: .kelvin
        }
    }
}
