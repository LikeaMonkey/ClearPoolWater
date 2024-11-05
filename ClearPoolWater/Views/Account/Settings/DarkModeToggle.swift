//
//  DarkModeToggle.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct DarkModeToggle: View {
    @AppStorage("darkMode") var darkMode = false

    var body: some View {
        Toggle(isOn: $darkMode) {
            HStack {
                Image(systemName: "sun.max")
                Text("Dark Mode")
            }
        }
    }
}

#Preview {
    DarkModeToggle()
}
