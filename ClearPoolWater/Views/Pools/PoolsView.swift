//
//  PoolsView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import SwiftUI

struct PoolsView: View {
    @State private var viewModel = PoolsViewModel()

    var body: some View {
        LoadableView(state: viewModel.state) {
            Task {
                await viewModel.fetch()
            }
        } content: {
            poolsList
        }
        .fancyBackground()
        .navigationTitle("Pools")
        .toolbar {
            addPoolToolbarItem
        }
        .task {
            await viewModel.fetch()
        }
    }

    private var poolsList: some View {
        ScrollView {
            VStack(spacing: 20) {
                if viewModel.pools.isEmpty {
                    Text("No pools yet")
                        .font(.title)
                } else {
                    ForEach(viewModel.pools) { pool in
                        poolRow(for: pool)
                    }
                }
            }
            .padding()
        }
    }

    private func poolRow(for pool: Pool) -> some View {
        PoolRow(
            pool: pool,
            poolCondition: viewModel.conditions[pool.id]!,
            waterStatus: viewModel.waterStatuses[pool.id]!
        ) {
            Task {
                await viewModel.deletePool(poolId: pool.id)
            }
        }
        .buttonStyle(.plain)
    }

    private var addPoolToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            CreatePoolButton {
                Task {
                    await viewModel.fetch()
                }
            }
        }
    }
}

#Preview {
    PoolsView()
}
