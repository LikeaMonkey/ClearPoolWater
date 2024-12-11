//
//  PoolWaterStatusSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct PoolWaterStatusSection: View {
    @State private var viewModel: WaterStatusViewModel

    @State private var isConfirmationDialogPresented = false
    @State private var isWaterStatusSheetPresented = false
    @State private var isScanViewPresented = false

    init(poolId: Int) {
        viewModel = WaterStatusViewModel(poolId: poolId)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Water Balance")
                    .font(.headline)
                Spacer()
                Button("Update") {
                    isConfirmationDialogPresented.toggle()
                }
                .disabled(viewModel.waterStatusId == nil)
            }

            if !viewModel.isLoaded || viewModel.isLoading {
                ProgressView()
                    .frame(alignment: .center)
            } else {
                waterTraitGauges
            }
        }
        .padding(20)
        .background(.regularMaterial)
        .cornerRadius(10)
        .task {
            await viewModel.fetchWaterStatus()
        }
        .confirmationDialog(
            "Update water status",
            isPresented: $isConfirmationDialogPresented,
            titleVisibility: .visible
        ) {
            Button("Manual") {
                isWaterStatusSheetPresented.toggle()
            }
            Button("Scan") {
                isScanViewPresented.toggle()
            }
        }
        .sheet(isPresented: $isWaterStatusSheetPresented) {
            NavigationView {
                UpdateWaterStatusView(
                    poolId: viewModel.poolId,
                    waterStatusId: viewModel.waterStatusId!
                )
            }
            .presentationDetents([.medium])
            .onDisappear {
                Task {
                    await viewModel.fetchWaterStatus()
                }
            }
        }
        .fullScreenCover(isPresented: $isScanViewPresented) {
            NavigationStack {
                ScanView()
            }
        }
    }

    private var waterTraitGauges: some View {
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

#Preview {
    PoolWaterStatusSection(poolId: 1)
}
