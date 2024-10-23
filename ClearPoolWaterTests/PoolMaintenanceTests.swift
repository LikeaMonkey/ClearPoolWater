//
//  PoolMaintenanceTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

import Testing

@testable import ClearPoolWater

//struct PoolMaintenanceTests {
//
//    private var exampleTraits: SwimmingPool.WaterTraits {
//        .init(
//            pH: WaterTraitFactory.create(type: .ph, value: 7.3),
//            alkalinity: WaterTraitFactory.create(type: .alkalinity, value: 81),
//            chlorineLevel: WaterTraitFactory.create(type: .chlorine, value: 1.4),
//            temperature: WaterTraitFactory.create(type: .temperature, value: 28)
//        )
//    }
//
//    @Test func noTasks() async throws {
//        let tasks = PoolMaintenance.generateTasks(for: exampleTraits)
//        #expect(tasks.isEmpty)
//    }
//
//    @Test func lowPhTask() async throws {
//        var traits = exampleTraits
//        traits.pH.value = 6.8
//
//        let tasks = PoolMaintenance.generateTasks(for: traits)
//        try #require(tasks.count == 1)
//
//        let expected = MaintenanceTask(
//            problem: "PH is low.",
//            solution: "Add pH plus.",
//            priority: .high
//        )
//        #expect(tasks.first! == expected)
//    }
//
//    @Test func highPhTask() async throws {
//        var traits = exampleTraits
//        traits.pH.value = 8.0
//
//        let tasks = PoolMaintenance.generateTasks(for: traits)
//        try #require(tasks.count == 1)
//
//        let expected = MaintenanceTask(
//            problem: "PH is high.",
//            solution: "Add pH minus.",
//            priority: .high
//        )
//        #expect(tasks.first! == expected)
//    }
//
//    @Test func lowAlkalinityTask() async throws {
//        var traits = exampleTraits
//        traits.alkalinity.value = 70
//
//        let tasks = PoolMaintenance.generateTasks(for: traits)
//        try #require(tasks.count == 1)
//
//        let expected = MaintenanceTask(
//            problem: "Alkalinity is low.",
//            solution: "Add alkalinity increaser.",
//            priority: .high
//        )
//        #expect(tasks.first! == expected)
//    }
//
//    @Test func highAlkalinityTask() async throws {
//        var traits = exampleTraits
//        traits.alkalinity.value = 150
//
//        let tasks = PoolMaintenance.generateTasks(for: traits)
//        try #require(tasks.count == 1)
//
//        let expected = MaintenanceTask(
//            problem: "Alkalinity is high",
//            solution: "add alkalinity reducer.",
//            priority: .high
//        )
//        #expect(tasks.first! == expected)
//    }
//
//    @Test func lowChlorineTask() async throws {
//        var traits = exampleTraits
//        traits.chlorineLevel.value = 0.3
//
//        let tasks = PoolMaintenance.generateTasks(for: traits)
//        try #require(tasks.count == 1)
//
//        let expected = MaintenanceTask(
//            problem: "Chlorine level is low.",
//            solution: "Add more chlorine.",
//            priority: .high
//        )
//        #expect(tasks.first! == expected)
//    }
//
//    @Test func highChlorineTask() async throws {
//        var traits = exampleTraits
//        traits.chlorineLevel.value = 5
//
//        let tasks = PoolMaintenance.generateTasks(for: traits)
//        try #require(tasks.count == 1)
//
//        let expected = MaintenanceTask(
//            problem: "Chlorine level is high.",
//            solution: "Reduce chlorine use.",
//            priority: .medium
//        )
//        #expect(tasks.first! == expected)
//    }
//
//    @Test func lowTemperatureTask() async throws {
//        var traits = exampleTraits
//        traits.temperature.value = 22
//
//        let tasks = PoolMaintenance.generateTasks(for: traits)
//        try #require(tasks.count == 1)
//
//        let expected = MaintenanceTask(
//            problem: "Water temperature is low.",
//            solution: "Increase heating.",
//            priority: .low
//        )
//        #expect(tasks.first! == expected)
//    }
//
//    @Test func highTemperatureTask() async throws {
//        var traits = exampleTraits
//        traits.temperature.value = 32
//
//        let tasks = PoolMaintenance.generateTasks(for: traits)
//        try #require(tasks.count == 1)
//
//        let expected = MaintenanceTask(
//            problem: "Water temperature is high.",
//            solution: "Reduce heating.",
//            priority: .low
//        )
//        #expect(tasks.first! == expected)
//    }
//
//    @Test func allTasks() async throws {
//        var traits = exampleTraits
//        traits.pH.value = 6.8
//        traits.alkalinity.value = 70
//        traits.chlorineLevel.value = 5
//        traits.temperature.value = 32
//
//        let tasks = PoolMaintenance.generateTasks(for: traits)
//
//        #expect(tasks.count == 4)
//    }
//}
