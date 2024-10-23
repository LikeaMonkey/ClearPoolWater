//
//  Pool.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.10.24.
//

import Foundation

struct Pool: Codable, Identifiable, Equatable {
    var id: Int? = nil

    let name: String

    // TODO: Add metrics system
    var waterLevel: Double  // Current water level in liters or meters
    let waterCapacity: Double  // Maximum capacity of the pool in liters or meters

    var filterType: FilterType

    static var example: Pool {
        Pool(
            name: "Test pool",
            waterLevel: 0.8,
            waterCapacity: 5,
            filterType: .cartridge
        )
    }
}

extension Pool {
    enum FilterType: String, Codable, CaseIterable, Identifiable {
        case sand, cartridge, de  // Diatomaceous Earth (DE)

        func toString() -> String {
            switch self {
            case .sand: return "Sand"
            case .cartridge: return "Cartridge"
            case .de: return "DE"
            }
        }

        var id: Self { self }
    }
}

extension Pool {
    struct Create: Codable {
        var name: String
        var waterLevel: Double
        var waterCapacity: Double
        var filterType: FilterType
        var user: Int
    }
}
