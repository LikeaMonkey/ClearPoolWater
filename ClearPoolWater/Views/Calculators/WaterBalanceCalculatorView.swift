//
//  WaterBalanceCalculatorView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 31.10.24.
//

import SwiftUI

enum WaterBalanceCalculatorFocusField: Hashable {
    case volume, current, target, dosageAmount, dosageVolume, dosageRate
}

struct WaterBalanceCalculatorView: View {
    @State private var model = WaterBalanceCalculatorViewModel()

    @FocusState private var focusedField: WaterBalanceCalculatorFocusField?

    var body: some View {
        ScrollView {
            scrollViewContent
        }
        .scrollDismissesKeyboard(.immediately)
        .fancyBackground()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                    .fontWeight(.bold)
                }
            }
        }
        .navigationTitle("Calculator")
    }

    private var scrollViewContent: some View {
        VStack(spacing: 20) {
            PoolVolumeSection(
                poolVolumeValue: $model.poolVolume,
                focusedField: $focusedField
            )

            Divider()

            AdjustmentSection(
                currentValue: $model.currentValue,
                targetValue: $model.targetValue,
                focusedField: $focusedField
            )

            Divider()

            DosageSection(dosage: $model.dosage, focusedField: $focusedField)

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
