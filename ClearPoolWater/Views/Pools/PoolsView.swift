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
            CreatePoolButton {
                Task {
                    await viewModel.fetch()
                }
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    PoolsView()
}
