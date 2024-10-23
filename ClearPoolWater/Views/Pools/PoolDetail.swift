//
//  PoolDetail.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

import SwiftUI

struct PoolDetail: View {
    let pool: Pool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                PoolInfoSection(pool: pool)

                // TODO: Can we crash here
                PoolWaterStatusSection(poolID: pool.id!)

                PoolStatusSection(poolID: pool.id!)
            }
            .navigationTitle(pool.name)
            .padding()
        }
        .navigationTitle(pool.name)
    }
}

#Preview {
    PoolDetail(pool: .example)
}
