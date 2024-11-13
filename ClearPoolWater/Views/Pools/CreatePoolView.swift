//
//  CreatePoolView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

import SwiftUI

struct CreatePoolView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = CreatePoolViewModel()

    var body: some View {
        List {
            Section {
                TextField("Name", text: $viewModel.name)
            }

            Section {
                waterLevelRow
                waterCapacityRow
            }
            .listRowSeparator(.hidden)

            Section {
                FilterSystemPicker(filterType: $viewModel.filterType)
            }
        }
        .listStyle(.insetGrouped)
        .contentMargins(.top, 12)
        .navigationTitle("New Pool")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .confirmationAction) {
                Button("Add") {
                    Task {
                        await viewModel.addNewPool()
                        dismiss()
                    }
                }
            }
        }
    }

    private var waterLevelRow: some View {
        TitledView(title: "Water Level") {
            SliderTextFieldView(
                value: $viewModel.waterLevel,
                range: 0...1,
                step: 0.05
            )
        }
    }

    private var waterCapacityRow: some View {
        TitledView(title: "Water Capacity") {
            SliderTextFieldView(
                value: $viewModel.waterCapacity,
                range: 0...150,
                step: 0.5
            )
        }
    }
}

#Preview {
    CreatePoolView()
}
