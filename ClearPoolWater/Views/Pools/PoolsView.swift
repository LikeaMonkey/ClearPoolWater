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
        BackgroundWrapper {
            LoadableView(state: viewModel.state) {
                Task {
                    await viewModel.fetchPools()
                }
            } content: {
                content
            }
        }
        .navigationTitle("Pools")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                CreatePoolButton {
                    Task {
                        await viewModel.fetchPools()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchPools()
        }
    }

    private var content: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.pools) { pool in
                    navigationLink(for: pool)
                }
            }
            .padding()
        }
    }

    private func navigationLink(for pool: Pool) -> some View {
        NavigationLink(destination: PoolDetail(pool: pool)) {
            PoolCard(pool: pool)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PoolsView()
}
