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
                TitledView(title: "Pool Volume") {
                    SliderTextFieldView(
                        value: $model.poolVolume,
                        range: 0...150,
                        step: 0.5
                    )
                }

                Divider()

                VStack {
                    TitledView(title: "Current pH") {
                        SliderTextFieldView(
                            value: $model.currentValue,
                            range: 0...14,
                            step: 0.1
                        )
                    }
                    TitledView(title: "Target pH") {
                        SliderTextFieldView(
                            value: $model.targetValue,
                            range: 0...14,
                            step: 0.1
                        )
                    }
                }

                Divider()

                VStack {
                    TitledView(title: "Dosage amount") {
                        SliderTextFieldView(
                            value: $model.dosage.amount,
                            range: 10...1000,
                            step: 10
                        )
                    }
                    TitledView(title: "Dosage volume") {
                        SliderTextFieldView(
                            value: $model.dosage.volume,
                            range: 1...100,
                            step: 0.5
                        )
                    }
                    TitledView(title: "Dosage value") {
                        SliderTextFieldView(
                            value: $model.dosage.increasedValue,
                            range: -1...1,
                            step: 0.1
                        )
                    }
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
