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
        ZStack {
            BackgroundView()

            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView()

                case .success:
                    List {
                        PoolTaskSectionView(title: "Maintenance", tasks: viewModel.maintenanceTasks)
                        PoolTaskSectionView(title: "Cleaning", tasks: viewModel.cleaningTasks)
                        PoolTaskSectionView(title: "Testing", tasks: viewModel.testingTasks)
                    }
                    .listStyle(.insetGrouped)

                case .failure:
                    ErrorView {
                        Task {
                            await viewModel.fetchPoolTasks()
                        }
                    }
                }
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
