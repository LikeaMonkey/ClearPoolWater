//
//  PoolTasksViewModelTests.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 14.11.24.
//

import Testing

@testable import ClearPoolWater

struct PoolTasksViewModelTests {
    @Test
    func testFetchSuccess() async {
        let tasks: [PoolTask] = [
            PoolTask(code: .brush, priority: .low, type: .cleaning),
            PoolTask(code: .inspect, priority: .medium, type: .maintenance),
            PoolTask(code: .testWater, priority: .high, type: .testing),
        ]
        let model = PoolTasksViewModel(poolId: 1, apiClient: MockAPIManager(result: tasks))

        await model.fetchPoolTasks()

        #expect(model.state == .success)

        #expect(model.cleaningTasks.count == 1)
        #expect(model.maintenanceTasks.count == 1)
        #expect(model.testingTasks.count == 1)
    }

    @Test
    func testFetchFail() async {
        let error = APIError.invalidResponse
        let model = PoolTasksViewModel(poolId: 1, apiClient: MockAPIManager(error: error))

        await model.fetchPoolTasks()

        #expect(model.state == .failure)

        #expect(model.cleaningTasks.isEmpty)
        #expect(model.maintenanceTasks.isEmpty)
        #expect(model.testingTasks.isEmpty)
    }

    @Test
    func testCleaningTasksSorting() async throws {
        let tasks: [PoolTask] = [
            PoolTask(code: .skim, priority: .pending, type: .cleaning),
            PoolTask(code: .brush, priority: .low, type: .cleaning),
            PoolTask(code: .vacuum, priority: .medium, type: .cleaning),
            PoolTask(code: .cleanFilter, priority: .high, type: .cleaning),
        ]
        let model = PoolTasksViewModel(poolId: 1, apiClient: MockAPIManager(result: tasks))

        await model.fetchPoolTasks()

        #expect(model.state == .success)

        try #require(model.cleaningTasks.count == 4)
        #expect(model.cleaningTasks[0].code == .cleanFilter)
        #expect(model.cleaningTasks[1].code == .vacuum)
        #expect(model.cleaningTasks[2].code == .brush)
        #expect(model.cleaningTasks[3].code == .skim)
    }

    @Test
    func testMaintenanceTasksSorting() async throws {
        let tasks: [PoolTask] = [
            PoolTask(code: .skim, priority: .pending, type: .maintenance),
            PoolTask(code: .brush, priority: .low, type: .maintenance),
            PoolTask(code: .vacuum, priority: .medium, type: .maintenance),
            PoolTask(code: .cleanFilter, priority: .high, type: .maintenance),
        ]
        let model = PoolTasksViewModel(poolId: 1, apiClient: MockAPIManager(result: tasks))

        await model.fetchPoolTasks()

        #expect(model.state == .success)

        try #require(model.maintenanceTasks.count == 4)
        #expect(model.maintenanceTasks[0].code == .cleanFilter)
        #expect(model.maintenanceTasks[1].code == .vacuum)
        #expect(model.maintenanceTasks[2].code == .brush)
        #expect(model.maintenanceTasks[3].code == .skim)
    }

    @Test
    func testTestingTasksSorting() async throws {
        let tasks: [PoolTask] = [
            PoolTask(code: .skim, priority: .pending, type: .testing),
            PoolTask(code: .brush, priority: .low, type: .testing),
            PoolTask(code: .vacuum, priority: .medium, type: .testing),
            PoolTask(code: .cleanFilter, priority: .high, type: .testing),
        ]
        let model = PoolTasksViewModel(poolId: 1, apiClient: MockAPIManager(result: tasks))

        await model.fetchPoolTasks()

        #expect(model.state == .success)

        try #require(model.testingTasks.count == 4)
        #expect(model.testingTasks[0].code == .cleanFilter)
        #expect(model.testingTasks[1].code == .vacuum)
        #expect(model.testingTasks[2].code == .brush)
        #expect(model.testingTasks[3].code == .skim)
    }
}
