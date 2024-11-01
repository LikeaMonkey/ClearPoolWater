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
            VStack(spacing: 20) {
                WaterTraitSlider(
                    value: $model.poolVolume,
                    range: 0...150,
                    step: 0.5,
                    title: "Pool Volume: "
                )

                Divider()

                VStack {
                    WaterTraitSlider(
                        value: $model.currentValue,
                        range: 0...14,
                        step: 0.1,
                        title: "Current pH: "
                    )
                    WaterTraitSlider(
                        value: $model.targetValue,
                        range: 0...14,
                        step: 0.1,
                        title: "Target pH: "
                    )
                }

                Divider()

                VStack {
                    WaterTraitSlider(
                        value: $model.dosage.amount,
                        range: 10...1000,
                        step: 10,
                        title: "Dosage amount: "
                    )
                    WaterTraitSlider(
                        value: $model.dosage.volume,
                        range: 1...100,
                        step: 0.5,
                        title: "Dosage volume: "
                    )
                    WaterTraitSlider(
                        value: $model.dosage.increasedValue,
                        range: 0...1,
                        step: 0.1,
                        title: "Dosage value: "
                    )
                }

                Button("Calculate") {
                    model.calculate()
                }
                .buttonStyle(.borderedProminent)

                Divider()

                HStack {
                    Text("Result: ")
                    Text(
                        model.result != nil
                            ? "Add \(model.result!.formatted()) gr" : "Need more info"
                    )
                }
                .padding()
                .ignoresSafeArea()
                .frame(maxWidth: .infinity)
                .background(model.result != nil ? .green.opacity(0.5) : .white)
            }
            .padding()
        }
        .navigationTitle("Calculator")
    }
}

#Preview {
    WaterBalanceCalculatorView()
}
