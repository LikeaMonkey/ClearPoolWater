//
//  TabView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import SwiftUI

struct PoolTabView: View {
    var body: some View {
        TabView {
            Tab("Pools", systemImage: "figure.pool.swim.circle") {
                PoolsView()
                    .fancyNavigationStack()
            }

            Tab("Calculator", systemImage: "plus.forwardslash.minus") {
                WaterBalanceCalculatorView()
                    .fancyNavigationStack()
            }

            Tab("Prediction", systemImage: "photo") {
                PredictionView()
                    .fancyNavigationStack()
            }

            Tab("Account", systemImage: "person.crop.circle.fill") {
                AccountView()
                    .fancyNavigationStack()
            }
        }
    }
}

#Preview {
    PoolTabView()
}
