//
//  PoolTask.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 24.10.24.
//

struct PoolTask: Codable {
    var code: Code
    var priority: Priority
    var type: `Type`
}

extension PoolTask {
    enum Code: Codable {
        /// Water status trait task codes
        case lowPh(diff: Double)
        case highPh(diff: Double)
        case lowChlorine(diff: Double)
        case highChlorine(diff: Double)
        case lowAlkalinity(diff: Double)
        case highAlkalinity(diff: Double)
        case lowTemperature(diff: Double)
        case highTemperature(diff: Double)

        /// Pool status task codes
        case skim
        case vacuum
        case brush
        case emptyBaskets
        case testWater
        case cleanFilter
        case runPump
        case inspect
    }

    enum Priority: String, Codable {
        case pending, low, medium, high
    }

    enum `Type`: String, Codable {
        case maintenance, cleaning, testing
    }
}
