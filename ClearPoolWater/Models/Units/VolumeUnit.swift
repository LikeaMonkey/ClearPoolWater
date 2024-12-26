//
//  VolumeUnit.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.12.24.
//
import Foundation

enum VolumeUnit: String, CaseIterable, Identifiable {
    case cubicMeters, liters, imperialGallons, gallons

    var id: String { rawValue }

    var title: String {
        switch self {
        case .cubicMeters: "Cubic meters"
        case .liters: "Liters"
        case .imperialGallons: "Imperial gallons"
        case .gallons: "US gallons"
        }
    }

    var unit: UnitVolume {
        switch self {
        case .cubicMeters: .cubicMeters
        case .liters: .liters
        case .imperialGallons: .imperialGallons
        case .gallons: .gallons
        }
    }
}
