//
//  Maintenance.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.10.24.
//

import Foundation

struct MaintenanceTask: Equatable, Identifiable {
    let id = UUID()

    let problem: String
    let solution: String
    let priority: Priority

    enum Priority: Comparable {
        case low, medium, high

        func toString() -> String {
            switch self {
            case .low: return "Low"
            case .medium: return "Medium"
            case .high: return "High"
            }
        }
    }

    static func == (lhs: MaintenanceTask, rhs: MaintenanceTask) -> Bool {
        lhs.problem == rhs.problem && lhs.solution == rhs.solution && lhs.priority == rhs.priority
    }
}
