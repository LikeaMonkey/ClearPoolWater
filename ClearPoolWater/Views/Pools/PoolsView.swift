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
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.pools) { pool in
                    NavigationLink(destination: PoolDetail(pool: pool)) {
                        PoolCard(pool: pool)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .navigationTitle("Pools")
        .toolbar {
            //TODO: Should I add it to ToolbarItem here
            CreatePoolButton {
                Task {
                    await viewModel.fetchPools()
                }
            }
        }
        .task {
            await viewModel.fetchPools()
        }
    }
}

#Preview {
    PoolsView()
}
