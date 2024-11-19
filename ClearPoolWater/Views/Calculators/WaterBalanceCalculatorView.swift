//
//  WaterBalanceCalculatorView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 31.10.24.
//

import SwiftUI

struct WaterBalanceCalculatorView: View {
    @State private var model = WaterBalanceCalculatorViewModel()

    var body: some View {
        ScrollView {
            scrollViewContent
        }
        .fancyBackground()
        .navigationTitle("Calculator")
    }

    private var scrollViewContent: some View {
        VStack(spacing: 20) {
            PoolVolumeSection(poolVolumeValue: $model.poolVolume)

            Divider()

            AdjustmentSection(
                currentValue: $model.currentValue,
                targetValue: $model.targetValue
            )

            Divider()

            DosageSection(dosage: $model.dosage)

            Button("Calculate") {
                model.calculate()
            }
            .buttonStyle(.borderedProminent)

            Divider()

            CalculatorResultView(resultValue: model.result)
        }
        .padding()
    }
}

#Preview {
    WaterBalanceCalculatorView()
}
