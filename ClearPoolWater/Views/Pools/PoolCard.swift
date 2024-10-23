//
//  PoolCard.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.10.24.
//

import SwiftUI

struct PoolCard: View {
    let pool: Pool

    var body: some View {
        VStack(alignment: .leading) {
            Text(pool.name)
                .font(.headline)
                .padding(.bottom, 8)
            HStack {
                Text("Water level: ")
                Spacer()
                Text(pool.waterLevel.formatted())
                    .font(.subheadline)
            }
            HStack {
                Text("Water capacity: ")
                Spacer()
                Text(pool.waterCapacity.formatted())
                    .font(.subheadline)
            }
            HStack {
                Text("Filter type: ")
                Spacer()
                Text(pool.filterType.toString())
                    .font(.subheadline)
            }
        }
        .padding(20)
        .background(.pool)
        .cornerRadius(10)
    }
}

#Preview {
    PoolCard(pool: Pool.example)
}
