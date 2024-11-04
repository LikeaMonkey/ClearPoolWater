//
//  PoolTaskRowView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct PoolTaskRowView: View {
    private let task: PoolTask
    private let priorityMessage: LocalizedStringKey

    init(task: PoolTask) {
        self.task = task
        priorityMessage = PoolTaskRowView.message(for: task.priority)
    }

    var body: some View {
        HStack(spacing: 12) {
            PoolTaskPriorityIndicator(priority: task.priority)

            VStack(alignment: .leading, spacing: 4) {
                Text(task.code.description)
                    .font(.body)
                    .fontWeight(.medium)

                Text(priorityMessage)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }

    private static func message(for priority: PoolTask.Priority) -> LocalizedStringKey {
        switch priority {
        case .high:
            return "Needs attention"
        case .medium:
            return "Recommended action"
        case .low:
            return "Optional"
        case .pending:
            return "Need initial data to proceed"
        }
    }
}

#Preview {
    let lowTask = PoolTask(code: .brush, priority: .low, type: .cleaning)
    PoolTaskRowView(task: lowTask)

    let mediumTask = PoolTask(code: .brush, priority: .medium, type: .cleaning)
    PoolTaskRowView(task: mediumTask)

    let highTask = PoolTask(code: .brush, priority: .high, type: .cleaning)
    PoolTaskRowView(task: highTask)

    let pendingTask = PoolTask(code: .brush, priority: .pending, type: .cleaning)
    PoolTaskRowView(task: pendingTask)
}
