//
//  PoolRow.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.12.24.
//

import SwiftUI

struct PoolRow: View {
    let pool: Pool
    let poolCondition: PoolCondition
    let waterStatus: WaterStatus

    let onDeleteAction: () -> Void

    @Environment(\.temperatureUnit) private var temperatureUnit

    @State private var isPresented = false

    var body: some View {
        NavigationLink {
            PoolDetail(pool: pool)
        } label: {
            PoolCard(
                pool: pool,
                poolCondition: poolCondition,
                temperature: temperatureMeasurement,
                ph: waterStatus.ph,
                chlorine: waterStatus.chlorine,
                onViewAction: {
                    isPresented.toggle()
                },
                onDeleteAction: onDeleteAction
            )
        }
        .navigationDestination(isPresented: $isPresented) {
            PoolDetail(pool: pool)
        }
    }

    private var temperatureMeasurement: Measurement<UnitTemperature>? {
        guard let temperature = waterStatus.temperature else { return nil }

        return Measurement<UnitTemperature>(value: temperature, unit: UnitTemperature.celsius)
            .converted(to: temperatureUnit)
    }
}
