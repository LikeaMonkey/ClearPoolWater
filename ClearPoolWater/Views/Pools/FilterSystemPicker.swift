//
//  FilterSystemPicker.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.11.24.
//

import SwiftUI

struct FilterSystemPicker: View {
    @Binding var filterType: Pool.FilterType

    var body: some View {
        Picker("Filter system", selection: $filterType) {
            ForEach(Pool.FilterType.allCases) { type in
                Text(type.toString())
                    .tag(type)
            }
        }
    }
}

#Preview {
    FilterSystemPicker(filterType: .constant(.sand))
}
