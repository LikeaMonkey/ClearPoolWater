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
        if viewModel.isLoading {
            ProgressView()
        }

        List {
            Section(header: Text("Maintenance")) {
                ForEach(viewModel.maintenanceTasks, id: \.self) { task in
                    Text(task)
                }
            }

            Section(header: Text("Cleaning")) {
                ForEach(viewModel.cleaningTasks, id: \.self) { task in
                    Text(task)
                }
            }

            Section(header: Text("Testing")) {
                ForEach(viewModel.testingTasks, id: \.self) { task in
                    Text(task)
                }
            }
        }
        .navigationTitle("Tasks")
        .task {
            await viewModel.fetchPoolTasks()
        }
    }
}

#Preview {
    PoolTasksView(poolId: 1)
}
