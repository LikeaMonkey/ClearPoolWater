//
//  UpdateWaterStatusView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

import SwiftUI

struct UpdateWaterStatusView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: WaterStatusViewModel

    init(poolID: Int) {
        viewModel = WaterStatusViewModel(poolID: poolID)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                TitledView(title: "Ph: ") {
                    TextField("Ph", text: $viewModel.ph)
                        .textFieldStyle(.roundedBorder)
                }
                TitledView(title: "Chlorine: ") {
                    TextField("Chlorine", text: $viewModel.chlorine)
                        .textFieldStyle(.roundedBorder)
                }
                TitledView(title: "Alkalinity: ") {
                    TextField("Alkalinity", text: $viewModel.alkalinity)
                        .textFieldStyle(.roundedBorder)
                }
                TitledView(title: "Temperature: ") {
                    TextField("Temperature", text: $viewModel.temperature)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("Update water status")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button("Done") {
                    Task {
                        await viewModel.save()
                        dismiss()
                    }
                }
            }
        }
        .task {
            await viewModel.fetch()
        }
    }
}

#Preview {
    UpdateWaterStatusView(poolID: 1)
}
