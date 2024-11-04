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

                UpdateWaterStatusButton(
                    poolId: viewModel.poolId,
                    waterStatusId: viewModel.waterStatusId
                ) {
                    Task {
                        await viewModel.fetchWaterStatus()
                    }
                }
            }

            if !viewModel.isLoaded || viewModel.isLoading {
                ProgressView()
                    .frame(alignment: .center)
            } else {
                HStack {
                    WaterParameterGauge(
                        name: "pH",
                        value: viewModel.ph,
                        range: 0...14,
                        idealRange: 7.2...7.6
                    )
                    Spacer()
                    WaterParameterGauge(
                        name: "Cl",
                        value: viewModel.chlorine,
                        range: 0...10,
                        idealRange: 1...1.5
                    )
                    Spacer()
                    WaterParameterGauge(
                        name: "Alkal",
                        value: viewModel.alkalinity,
                        range: 0...300,
                        idealRange: 80...100
                    )
                    Spacer()
                    WaterParameterGauge(
                        name: "Temp",
                        value: viewModel.temperature,
                        range: 0...50,
                        idealRange: 24...30
                    )
                }
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
