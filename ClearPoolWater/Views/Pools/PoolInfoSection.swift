//
//  PoolInfoSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct PoolInfoSection: View {
    let pool: Pool

    @Environment(\.volumeUnit) private var volumeUnit

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Info")
                .font(.headline)

            VStack {
                PoolInfoRow(
                    title: "Water level",
                    value: pool.waterLevel.formatted(.percent)
                )
                PoolInfoRow(
                    title: "Water capacity",
                    value: waterCapacityFormatted
                )
                PoolInfoRow(
                    title: "Filter system",
                    value: pool.filterType.toString()
                )
            }
        }
        .cardStyle()
    }

    private var waterCapacityFormatted: String {
        var measurement = Measurement(value: pool.waterCapacity, unit: UnitVolume.cubicMeters)
        measurement.convert(to: volumeUnit)
        return measurement.formatted(
            .measurement(
                width: .abbreviated,
                usage: .asProvided,
                numberFormatStyle: numberFormatStyle
            )
        )
    }

    private var numberFormatStyle: FloatingPointFormatStyle<Double> {
        .number.precision(.fractionLength(0...1))
    }
}

#Preview {
    PoolInfoSection(pool: .example)
}
