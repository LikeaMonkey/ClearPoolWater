//
//  TabView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import SwiftUI

struct PoolTabView: View {
    var body: some View {
        if #available(iOS 18.0, *) {
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
        } else {
            TabView {
                PoolsView()
                    .fancyNavigationStack()
                    .tabItem {
                        Label("Pools", systemImage: "figure.pool.swim.circle")
                    }

                WaterBalanceCalculatorView()
                    .fancyNavigationStack()
                    .tabItem {
                        Label("Calculator", systemImage: "plus.forwardslash.minus")
                    }

                PredictionView()
                    .fancyNavigationStack()
                    .tabItem {
                        Label("Prediction", systemImage: "photo")
                    }

                AccountView()
                    .fancyBackground()
                    .tabItem {
                        Label("Account", systemImage: "person.crop.circle.fill")
                    }
            }
        }
    }
}

#Preview {
    PoolTabView()
}
