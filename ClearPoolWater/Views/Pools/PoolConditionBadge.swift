//
//  PoolConditionBadge.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 26.12.24.
//
import SwiftUI

struct PoolConditionBadge: View {
    let condition: PoolCondition

    var body: some View {
        Text(condition.text)
            .font(.subheadline)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(condition.color)
            .clipShape(Capsule())
    }
}

#Preview {
    PoolConditionBadge(condition: .good)
    PoolConditionBadge(condition: .okay)
    PoolConditionBadge(condition: .bad)
    PoolConditionBadge(condition: .unknown)
}
