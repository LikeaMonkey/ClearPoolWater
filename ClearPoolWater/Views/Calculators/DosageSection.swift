//
//  DosageSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct DosageSection: View {
    @Binding var dosage: ChemistryDosage

    var body: some View {
        VStack {
            TitledView(title: "Dosage amount") {
                SliderTextFieldView(
                    value: $dosage.amount,
                    range: 10...1000,
                    step: 10
                )
            }
            TitledView(title: "Dosage volume") {
                SliderTextFieldView(
                    value: $dosage.volume,
                    range: 1...100,
                    step: 0.5
                )
            }
            TitledView(title: "Dosage value") {
                SliderTextFieldView(
                    value: $dosage.increasedValue,
                    range: -1...1,
                    step: 0.1
                )
            }
        }
    }
}

#Preview {
    let dosage = ChemistryDosage(amount: 1, volume: 1, increasedValue: 1)
    DosageSection(dosage: .constant(dosage))
}
