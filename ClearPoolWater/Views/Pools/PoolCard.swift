//
//  PoolCard.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.10.24.
//

import SwiftUI

struct PoolCard: View {
    let pool: Pool
    let poolCondition: PoolCondition

    var temperature: Measurement<UnitTemperature>?
    let ph: Double
    let chlorine: Double

    let onViewAction: () -> Void
    let onDeleteAction: () -> Void

    @State private var isMenuPresented = false
    @State private var isShowingDialog = false

    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 16) {
                Text(pool.name)
                    .font(.headline)

                HStack(spacing: 8) {
                    Text("Condition")
                        .font(.subheadline)
                    PoolConditionBadge(condition: poolCondition)
                    Spacer()
                }
            }

            VStack(alignment: .trailing, spacing: 6) {
                Text(ph.formatted(numberFormatStyle) + " pH")
                Text(chlorine.formatted(numberFormatStyle) + " Cl")
                temperatureText
            }
            .font(.callout)
            .fontWeight(.semibold)

            Menu {
                Button("View") {
                    onViewAction()
                }
                Divider()
                Button("Delete", role: .destructive) {
                    isShowingDialog.toggle()
                }
            } label: {
                Image(systemName: "ellipsis")
            }
        }
        .cardStyle()
        .confirmationDialog(
            Constants.deletePoolConfirmationMessage,
            isPresented: $isShowingDialog,
            titleVisibility: .visible
        ) {
            Button("Delete Pool", role: .destructive) {
                onDeleteAction()
            }
        }
    }

    @ViewBuilder
    private var temperatureText: some View {
        if let temperature {
            Text(
                temperature.formatted(
                    .measurement(
                        width: .abbreviated,
                        usage: .asProvided,
                        numberFormatStyle: numberFormatStyle
                    )
                )
            )
        } else {
            EmptyView()
        }
    }

    private var numberFormatStyle: FloatingPointFormatStyle<Double> {
        .number.precision(.fractionLength(0...1))
    }
}

extension PoolCard {
    struct Constants {
        static let deletePoolConfirmationMessage =
            "Deleting the pool will erase all information about the pool. Are you sure you want to permanently delete this pool?"
    }
}

#Preview {
    PoolCard(
        pool: Pool.example,
        poolCondition: .good,
        temperature: Measurement(value: 28.6, unit: UnitTemperature.celsius),
        ph: 7.4,
        chlorine: 1.2,
        onViewAction: {},
        onDeleteAction: {}
    )
}
