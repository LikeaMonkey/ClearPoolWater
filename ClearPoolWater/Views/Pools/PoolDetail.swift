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
            VStack(alignment: .leading, spacing: 20) {
                PoolInfoSection(pool: pool)
                PoolWaterStatusSection(pool: pool)
                PoolStatusSection(poolId: pool.id)
            }
            .padding()
        }
        .fancyBackground()
        .navigationTitle(pool.name)
        .toolbar {
            NavigationLink(destination: PoolTasksView(poolId: pool.id)) {
                Image(systemName: "list.bullet.clipboard")
            }
        }
    }
}

#Preview {
    PoolDetail(pool: .example)
}
