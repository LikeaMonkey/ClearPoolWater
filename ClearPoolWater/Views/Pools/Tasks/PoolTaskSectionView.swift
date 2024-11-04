//
//  PoolTaskSectionView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct PoolTaskSectionView: View {
    let title: String
    let tasks: [PoolTask]

    var body: some View {
        Section(title) {
            ForEach(tasks, id: \.code) { task in
                PoolTaskRowView(task: task)
            }
        }
    }
}

#Preview {
    let maintenanceTask = PoolTask(code: .inspect, priority: .high, type: .maintenance)
    PoolTaskSectionView(title: "Maintenance", tasks: [maintenanceTask])

    let cleaningTask = PoolTask(code: .brush, priority: .medium, type: .cleaning)
    PoolTaskSectionView(title: "Cleaning", tasks: [cleaningTask])

    let testingTask = PoolTask(code: .testWater, priority: .low, type: .testing)
    PoolTaskSectionView(title: "Title", tasks: [testingTask])
}
