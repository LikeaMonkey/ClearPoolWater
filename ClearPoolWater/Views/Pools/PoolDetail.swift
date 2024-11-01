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
                PoolWaterStatusSection(poolId: pool.id!)

                PoolStatusSection(poolId: pool.id!)
            }
            .navigationTitle(pool.name)
            .padding()
        }
        .navigationTitle(pool.name)
        .toolbar {
            NavigationLink(destination: PoolTasksView(poolId: pool.id!)) {
                Image(systemName: "list.bullet.clipboard")
            }
        }
    }
}

#Preview {
    PoolDetail(pool: .example)
}
