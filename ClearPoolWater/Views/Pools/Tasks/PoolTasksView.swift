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
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    PoolTaskSectionView(title: "Maintenance", tasks: viewModel.maintenanceTasks)
                    PoolTaskSectionView(title: "Cleaning", tasks: viewModel.cleaningTasks)
                    PoolTaskSectionView(title: "Testing", tasks: viewModel.testingTasks)
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .navigationTitle("Pool Tasks")
        .task {
            await viewModel.fetchPoolTasks()
        }
    }
}

#Preview {
    PoolTasksView(poolId: 1)
}