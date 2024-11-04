//
//  PoolTaskPriorityIndicator.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct PoolTaskPriorityIndicator: View {
    private let icon: String
    private let color: Color

    init(priority: PoolTask.Priority) {
        icon = PoolTaskPriorityIndicator.icon(for: priority)
        color = PoolTaskPriorityIndicator.color(for: priority)
    }

    var body: some View {
        Image(systemName: icon)
            .foregroundColor(color)
            .font(.body)
    }

    private static func icon(for priority: PoolTask.Priority) -> String {
        switch priority {
        case .high:
            return "exclamationmark.triangle.fill"
        case .medium:
            return "exclamationmark.circle.fill"
        case .low:
            return "questionmark.circle.fill"
        case .pending:
            return "ellipsis.circle.fill"
        }
    }

    private static func color(for priority: PoolTask.Priority) -> Color {
        switch priority {
        case .high:
            return .red
        case .medium:
            return .yellow
        case .low:
            return .blue
        case .pending:
            return .gray
        }
    }
}

#Preview {
    PoolTaskPriorityIndicator(priority: .low)
    PoolTaskPriorityIndicator(priority: .medium)
    PoolTaskPriorityIndicator(priority: .high)
    PoolTaskPriorityIndicator(priority: .pending)
}
