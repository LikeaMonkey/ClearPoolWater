//
//  TemperaturePicker.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct TemperaturePicker: View {
    @AppStorage("temperature") var temperature = "celsius"

    var body: some View {
        Picker(selection: $temperature) {
            Text("Celsius")
                .tag("celsius")
            Text("Fahrenheit")
                .tag("fahrenheit")
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
