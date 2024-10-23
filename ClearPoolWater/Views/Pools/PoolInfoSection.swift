//
//  PoolInfoSection.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 21.10.24.
//

import SwiftUI

struct PoolInfoSection: View {
    let pool: Pool

    var body: some View {
        VStack(alignment: .leading) {
            Text("Info")
                .font(.headline)
                .padding(.bottom, 10)

            PoolInfoRow(
                title: "Water level",
                value: pool.waterLevel.formatted()
            )
            PoolInfoRow(
                title: "Water capacity",
                value: pool.waterCapacity.formatted()
            )
            PoolInfoRow(
                title: "Filter system",
                value: pool.filterType.toString()
            )
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(10)
    }
}

#Preview {
    PoolInfoSection(pool: .example)
}
