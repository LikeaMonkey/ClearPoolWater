//
//  UnitsPicker.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct UnitsPicker: View {
    @AppStorage("volume") private var volumeUnit = VolumeUnit.cubicMeters

    var body: some View {
        Picker(selection: $volumeUnit) {
            ForEach(VolumeUnit.allCases) { unit in
                Text(unit.title)
                    .tag(unit)
            }
        } label: {
            HStack {
                Image(systemName: "compass.drawing")
                Text("Volume Unit")
            }
        }
    }
}

#Preview {
    UnitsPicker()
}
