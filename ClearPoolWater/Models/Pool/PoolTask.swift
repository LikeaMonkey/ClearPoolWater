//
//  PoolTask.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 24.10.24.
//

struct PoolTask: Codable, Hashable {
    var code: Code
    var priority: Priority
    var type: `Type`
}

extension PoolTask {
    enum Code: Codable, Hashable {
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

    enum Priority: String, Codable, Comparable, Hashable {
        case pending, low, medium, high

        static func < (lhs: Priority, rhs: Priority) -> Bool {
            switch (lhs, rhs) {
            case (.pending, .low),
                (.pending, .medium),
                (.pending, .high),
                (.low, .medium),
                (.low, .high),
                (.medium, .high):
                return true
            default:
                return false
            }
        }
    }

    enum `Type`: String, Codable, Hashable {
        case maintenance, cleaning, testing
    }
}
