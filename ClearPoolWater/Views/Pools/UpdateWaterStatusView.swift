//
//  UpdateWaterStatusView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

import SwiftUI

struct UpdateWaterStatusView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: UpdateWaterStatusViewModel

    init(poolId: Int, waterStatusId: Int) {
        viewModel = UpdateWaterStatusViewModel(
            poolId: poolId,
            waterStatusId: waterStatusId
        )
    }

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .frame(alignment: .center)
            } else {
                VStack(spacing: 15) {
                    TitledView(title: "pH") {
                        SliderTextFieldView(value: $viewModel.ph, range: 0...14, step: 0.1)
                    }
                    TitledView(title: "Chlorine") {
                        SliderTextFieldView(value: $viewModel.chlorine, range: 0...15, step: 0.1)
                    }
                    TitledView(title: "Alkalinity") {
                        SliderTextFieldView(value: $viewModel.alkalinity, range: 0...300, step: 10)
                    }
                    TitledView(title: "Temperature") {
                        SliderTextFieldView(value: $viewModel.temperature, range: 0...50, step: 0.5)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationTitle("Update water status")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem {
                Button("Done") {
                    Task {
                        await viewModel.updateWaterStatus()
                        dismiss()
                    }
                }
            }
        }
        .task {
            await viewModel.fetchWaterStatus()
        }
    }
}

#Preview {
    UpdateWaterStatusView(poolId: 1, waterStatusId: 1)
}
