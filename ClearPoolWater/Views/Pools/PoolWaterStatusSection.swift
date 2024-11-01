//
//  PoolWaterStatusSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct PoolWaterStatusSection: View {
    @State private var viewModel: WaterStatusViewModel

    init(poolId: Int) {
        viewModel = WaterStatusViewModel(poolId: poolId)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Water traits")
                    .font(.headline)

                Spacer()

                UpdateWaterStatusButton(poolId: viewModel.poolId) {
                    Task {
                        await viewModel.fetchWaterStatus()
                    }
                }
            }

            HStack {
                WaterParameterView(title: "pH", subtitle: viewModel.ph)
                WaterParameterView(title: "Cl", subtitle: viewModel.chlorine)
                WaterParameterView(title: "Alkal", subtitle: viewModel.alkalinity)
                WaterParameterView(title: "Temp", subtitle: viewModel.temperature)
            }
        }
        .padding()
        .task {
            await viewModel.fetchWaterStatus()
        }
    }
}

#Preview {
    PoolWaterStatusSection(poolId: 1)
}
