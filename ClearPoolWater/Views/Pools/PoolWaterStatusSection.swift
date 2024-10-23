//
//  PoolWaterStatusSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct PoolWaterStatusSection: View {
    @State private var viewModel: WaterStatusViewModel

    init(poolID: Int) {
        viewModel = WaterStatusViewModel(poolID: poolID)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Water traits")
                .font(.headline)
                .padding(.bottom, 10)

            PoolInfoRow(title: "Ph: ", value: viewModel.ph)
            PoolInfoRow(title: "Chlorine: ", value: viewModel.chlorine)
            PoolInfoRow(title: "Alkalinity: ", value: viewModel.alkalinity)
            PoolInfoRow(title: "Temperature: ", value: viewModel.temperature)

            UpdateWaterStatusButton(poolID: viewModel.poolID) {
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
    PoolWaterStatusSection(poolID: 1)
}
