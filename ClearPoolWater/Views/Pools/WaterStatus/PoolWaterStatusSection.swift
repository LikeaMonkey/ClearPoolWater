//
//  PoolWaterStatusSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct PoolWaterStatusSection: View {
    let pool: Pool

    @Environment(\.temperatureUnit) private var temperatureUnit

    @State private var viewModel = WaterStatusViewModel()

    @State private var isConfirmationDialogPresented = false
    @State private var isWaterStatusSheetPresented = false
    @State private var isScanViewPresented = false

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
        .cardStyle()
        .task {
            viewModel.setup(poolId: pool.id)
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
                    poolId: pool.id,
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
                ScanView(
                    pool: pool,
                    waterStatus: WaterStatus(
                        id: viewModel.waterStatusId!,
                        ph: viewModel.ph!,
                        chlorine: viewModel.chlorine!,
                        alkalinity: viewModel.alkalinity,
                        temperature: viewModel.temperature
                    )
                )
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
                value: temperature,
                range: temperatureRange,
                idealRange: temperatureIdealRange
            )
        }
    }

    private var temperature: Double? {
        guard let temperature = viewModel.temperature else { return nil }
        return convert(value: temperature, to: temperatureUnit)
    }

    private var temperatureRange: ClosedRange<Double> {
        let low = convert(value: 0, to: temperatureUnit)
        let high = convert(value: 50, to: temperatureUnit)
        return low...high
    }

    private var temperatureIdealRange: ClosedRange<Double> {
        let low = convert(value: 24, to: temperatureUnit)
        let high = convert(value: 30, to: temperatureUnit)
        return low...high
    }

    private func convert(value: Double, to unit: UnitTemperature) -> Double {
        var measurement = Measurement(value: value, unit: UnitTemperature.celsius)
        measurement.convert(to: unit)
        return measurement.value
    }
}

#Preview {
    PoolWaterStatusSection(pool: .example)
}
