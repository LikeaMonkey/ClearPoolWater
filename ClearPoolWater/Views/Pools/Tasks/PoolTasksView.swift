//
//  PoolTasksView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 23.10.24.
//

import SwiftUI

struct PoolTasksView: View {
    @State private var viewModel: PoolTasksViewModel

    init(poolId: Int) {
        viewModel = PoolTasksViewModel(poolId: poolId)
    }

    var body: some View {
        BackgroundWrapper {
            LoadableView(state: viewModel.state) {
                Task {
                    await viewModel.fetchPoolTasks()
                }
            } content: {
                tasksList
            }
        }
        .navigationTitle("Pool Tasks")
        .task {
            await viewModel.fetchPoolTasks()
        }
    }

    private var tasksList: some View {
        List {
            PoolTaskSectionView(
                title: "Maintenance",
                tasks: viewModel.maintenanceTasks
            )

            PoolTaskSectionView(
                title: "Cleaning",
                tasks: viewModel.cleaningTasks
            )

            PoolTaskSectionView(
                title: "Testing",
                tasks: viewModel.testingTasks
            )
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    PoolTasksView(poolId: 1)
}
