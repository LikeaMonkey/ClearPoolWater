//
//  DosageSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct DosageSection: View {
    @Binding var dosage: ChemistryDosage
    @FocusState.Binding var focusedField: WaterBalanceCalculatorFocusField?

    var body: some View {
        VStack {
            TitledView(title: "Dosage amount") {
                SliderTextFieldView(
                    value: $dosage.amount,
                    range: 0...1000,
                    step: 10
                )
                .focused($focusedField, equals: .dosageAmount)
            }
            TitledView(title: "Dosage volume") {
                SliderTextFieldView(
                    value: $dosage.volume,
                    range: 0...100,
                    step: 0.5
                )
                .focused($focusedField, equals: .dosageVolume)
            }
            TitledView(title: "Dosage value") {
                SliderTextFieldView(
                    value: $dosage.increasedValue,
                    range: -1...1,
                    step: 0.1
                )
                .focused($focusedField, equals: .dosageRate)
            }
        }
    }
}

#Preview {
    let dosage = ChemistryDosage(amount: 1, volume: 1, increasedValue: 1)
    let focusedField = FocusState<WaterBalanceCalculatorFocusField?>().projectedValue
    DosageSection(dosage: .constant(dosage), focusedField: focusedField)
}
