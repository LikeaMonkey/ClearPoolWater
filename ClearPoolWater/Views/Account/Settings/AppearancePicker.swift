//
//  AppearancePicker.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct AppearancePicker: View {
    @AppStorage("appearance") var appearance = Appearance.system

    var body: some View {
        Picker("Appearance", selection: $appearance) {
            ForEach(Appearance.allCases) { appearance in
                Text(appearance.rawValue.capitalized)
                    .tag(appearance)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    AppearancePicker()
}
