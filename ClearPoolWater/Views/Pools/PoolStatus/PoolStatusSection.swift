//
//  PoolStatusSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct PoolStatusSection: View {
    @State private var viewModel: PoolStatusViewModel

    init(poolId: Int) {
        viewModel = PoolStatusViewModel(poolId: poolId)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            header
                .padding(.bottom, 8)

            PoolInfoRow(title: "Skim", value: viewModel.skimDate)
            PoolInfoRow(title: "Vacuum", value: viewModel.vacuumDate)
            PoolInfoRow(title: "Brush", value: viewModel.brushDate)
            PoolInfoRow(title: "Empty Basket", value: viewModel.emptyBasketsDate)
            PoolInfoRow(title: "Test water", value: viewModel.testWaterDate)
            PoolInfoRow(title: "Clean Filter", value: viewModel.cleanFilterDate)
            PoolInfoRow(title: "Run Pump", value: viewModel.runPumpDate)
            PoolInfoRow(title: "Inspect", value: viewModel.inspectDate)
        }
        .padding(20)
        .background(.regularMaterial)
        .cornerRadius(10)
        .task {
            await viewModel.fetchPoolStatus()
        }
    }

    private var header: some View {
        HStack {
            Text("Maintenance")
                .font(.headline)

            Spacer()

            UpdatePoolStatusButton(poolId: viewModel.poolId) {
                Task {
                    await viewModel.fetchPoolStatus()
                }
            }
        }
    }
}

#Preview {
    PoolStatusSection(poolId: 1)
}
