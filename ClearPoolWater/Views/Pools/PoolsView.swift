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
                await viewModel.fetchPools()
            }
        } content: {
            ScrollView {
                pools
            }
        }
        .fancyBackground()
        .navigationTitle("Pools")
        .toolbar {
            addPoolToolbarItem
        }
        .task {
            await viewModel.fetchPools()
        }
    }

    private var pools: some View {
        VStack(spacing: 20) {
            ForEach(viewModel.pools) { pool in
                navigationLink(for: pool)
            }
        }
        .padding()
    }

    private func navigationLink(for pool: Pool) -> some View {
        NavigationLink(destination: PoolDetail(pool: pool)) {
            PoolCard(pool: pool)
        }
        .buttonStyle(.plain)
    }

    private var addPoolToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            CreatePoolButton {
                Task {
                    await viewModel.fetchPools()
                }
            }
        }
    }
}

#Preview {
    PoolsView()
}
