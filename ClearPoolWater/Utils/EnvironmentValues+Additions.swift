//
//  EnvironmentValues+Pool.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 20.12.24.
//
import SwiftUI

extension EnvironmentValues {
    @Entry var temperatureUnit = UnitTemperature.celsius
    @Entry var volumeUnit = UnitVolume.cubicMeters
}

extension View {
    func temperatureUnit(_ unit: UnitTemperature) -> some View {
        environment(\.temperatureUnit, unit)
    }

    func volumeUnit(_ unit: UnitVolume) -> some View {
        environment(\.volumeUnit, unit)
    }
}
