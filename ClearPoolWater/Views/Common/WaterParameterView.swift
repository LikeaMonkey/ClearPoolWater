//
//  WaterParameterView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 27.10.24.
//

import SwiftUI

struct WaterParameterView: View {
    var title: LocalizedStringKey
    var subtitle: String

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.title2)
                .frame(maxWidth: .infinity)
            Text(subtitle)
                .font(.title)
        }
        .padding(10)
        .background(.regularMaterial)
        .cornerRadius(10)
    }
}

#Preview {
    WaterParameterView(title: "pH", subtitle: "7,2")
}
