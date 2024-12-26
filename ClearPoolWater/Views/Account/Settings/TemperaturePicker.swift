//
//  TemperaturePicker.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct TemperaturePicker: View {
    @AppStorage("temperature") private var temperatureUnit = TemperatureUnit.celsius

    var body: some View {
        Picker(selection: $temperatureUnit) {
            ForEach(TemperatureUnit.allCases) { unit in
                Text(unit.rawValue.capitalized)
                    .tag(unit)
            }
        } label: {
            HStack {
                Image(systemName: "thermometer.variable")
                Text("Temperature")
            }
        }
    }
}

#Preview {
    TemperaturePicker()
}
