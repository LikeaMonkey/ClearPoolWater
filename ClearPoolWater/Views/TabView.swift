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
                NavigationStack {
                    PoolsView()
                        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                }
                .toolbarBackground(Color.poolBottomColor, for: .tabBar)
            }

            Tab("Calculator", systemImage: "plus.forwardslash.minus") {
                NavigationStack {
                    WaterBalanceCalculatorView()
                        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                }
                .toolbarBackground(Color.poolBottomColor, for: .tabBar)
            }

            Tab("Prediction", systemImage: "photo") {
                PredictionView()
                    .toolbarBackground(Color.poolBottomColor, for: .tabBar)
            }

            Tab("Account", systemImage: "person.crop.circle.fill") {
                NavigationStack {
                    AccountView()
                        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                }
            }
        }
    }
}

#Preview {
    PoolTabView()
}
