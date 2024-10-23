//
//  PoolMaintenance.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.10.24.
//

//struct PoolMaintenance {
//    // Check the pool and generate tasks
//    static func generateTasks(for waterParameters: SwimmingPool.WaterTraits) -> [MaintenanceTask] {
//        var tasks = [MaintenanceTask]()
//
//        if let phTask = checkPh(waterParameters.pH) {
//            tasks.append(phTask)
//        }
//        if let alkalinityTask = checkAlkalinity(waterParameters.alkalinity) {
//            tasks.append(alkalinityTask)
//        }
//        if let chlorineTask = checkChlorine(waterParameters.chlorineLevel) {
//            tasks.append(chlorineTask)
//        }
//        if let temperatureTask = checkTemperature(waterParameters.temperature) {
//            tasks.append(temperatureTask)
//        }
//
//        return tasks
//    }
//
//    private static func checkPh(_ pH: WaterTrait) -> MaintenanceTask? {
//        let result = WaterTraitChecker.check(trait: pH)
//        switch result {
//        case .normal:
//            return nil
//        case .belowMinimum:
//            return MaintenanceTask(
//                problem: "PH is low.",
//                solution: "Add pH plus.",
//                priority: .high
//            )
//        case .aboveMaximum:
//            return MaintenanceTask(
//                problem: "PH is high.",
//                solution: "Add pH minus.",
//                priority: .high
//            )
//        }
//    }
//
//    private static func checkAlkalinity(_ alkalinity: WaterTrait) -> MaintenanceTask? {
//        let result = WaterTraitChecker.check(trait: alkalinity)
//        switch result {
//        case .normal:
//            return nil
//        case .belowMinimum:
//            return MaintenanceTask(
//                problem: "Alkalinity is low.",
//                solution: "Add alkalinity increaser.",
//                priority: .high
//            )
//        case .aboveMaximum:
//            return MaintenanceTask(
//                problem: "Alkalinity is high",
//                solution: "add alkalinity reducer.",
//                priority: .high
//            )
//        }
//    }
//
//    private static func checkChlorine(_ chlorine: WaterTrait) -> MaintenanceTask? {
//        let result = WaterTraitChecker.check(trait: chlorine)
//        switch result {
//        case .normal:
//            return nil
//        case .belowMinimum:
//            return MaintenanceTask(
//                problem: "Chlorine level is low.",
//                solution: "Add more chlorine.",
//                priority: .high
//            )
//        case .aboveMaximum:
//            return MaintenanceTask(
//                problem: "Chlorine level is high.",
//                solution: "Reduce chlorine use.",
//                priority: .medium
//            )
//        }
//    }
//
//    /// Check temperature (optional, depends on user preference)
//    private static func checkTemperature(_ temperature: WaterTrait) -> MaintenanceTask? {
//        let result = WaterTraitChecker.check(trait: temperature)
//        switch result {
//        case .normal:
//            return nil
//        case .belowMinimum:
//            return MaintenanceTask(
//                problem: "Water temperature is low.",
//                solution: "Increase heating.",
//                priority: .low
//            )
//        case .aboveMaximum:
//            return MaintenanceTask(
//                problem: "Water temperature is high.",
//                solution: "Reduce heating.",
//                priority: .low
//            )
//        }
//    }
//}
