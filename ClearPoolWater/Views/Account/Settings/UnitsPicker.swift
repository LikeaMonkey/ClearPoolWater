//
//  UnitsPicker.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct UnitsPicker: View {
    @AppStorage("units") var units = "metric"

    var body: some View {
        Picker(selection: $units) {
            Text("Metric")
                .tag("metric")
            Text("Imperial")
                .tag("imperial")
        } label: {
            HStack {
                Image(systemName: "compass.drawing")
                Text("Units")
            }
        }
    }
}

#Preview {
    UnitsPicker()
}
