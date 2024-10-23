//
//  PoolStatusSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct PoolStatusSection: View {
    @State private var viewModel: PoolStatusViewModel

    init(poolID: Int) {
        viewModel = PoolStatusViewModel(poolID: poolID)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Pool status")
                .font(.headline)
                .padding(.bottom, 10)

            PoolInfoRow(title: "Skim", value: viewModel.skimDate)
            PoolInfoRow(title: "Vacuum", value: viewModel.vacuumDate)
            PoolInfoRow(title: "Brush", value: viewModel.brushDate)
            PoolInfoRow(title: "Empty Basket", value: viewModel.emptyBasketsDate)
            PoolInfoRow(title: "Test water", value: viewModel.testWaterDate)
            PoolInfoRow(title: "Clean Filter", value: viewModel.cleanFilterDate)
            PoolInfoRow(title: "Run Pump", value: viewModel.runPumpDate)
            PoolInfoRow(title: "Inspect", value: viewModel.inspectDate)

            UpdatePoolStatusButton(poolID: viewModel.poolID) {
                Task {
                    await viewModel.fetch()
                }
            }
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(10)
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    PoolStatusSection(poolID: 1)
}
