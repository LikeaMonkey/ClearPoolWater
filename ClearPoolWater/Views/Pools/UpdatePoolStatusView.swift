//
//  UpdatePoolStatusView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import SwiftUI

struct UpdatePoolStatusView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: UpdatePoolStatusViewModel

    init(poolID: Int) {
        viewModel = UpdatePoolStatusViewModel(poolID: poolID)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Toggle("Skim", isOn: $viewModel.skim)
                Toggle("Vacuum", isOn: $viewModel.vacuum)
                Toggle("Brush", isOn: $viewModel.brush)
                Toggle("EmptyBaskets", isOn: $viewModel.emptyBaskets)
                Toggle("TestWater", isOn: $viewModel.testWater)
                Toggle("CleanFilter", isOn: $viewModel.cleanFilter)
                Toggle("RunPump", isOn: $viewModel.runPump)
                Toggle("Inspect", isOn: $viewModel.inspect)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("Update pool status")
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
    UpdatePoolStatusView(poolID: 1)
}
