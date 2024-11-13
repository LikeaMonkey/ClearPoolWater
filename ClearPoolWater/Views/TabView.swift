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
                NavigationStackWrapper {
                    PoolsView()
                }
            }

            Tab("Calculator", systemImage: "plus.forwardslash.minus") {
                NavigationStackWrapper {
                    WaterBalanceCalculatorView()
                }
            }

            Tab("Prediction", systemImage: "photo") {
                NavigationStackWrapper {
                    PredictionView()
                }
            }

            Tab("Account", systemImage: "person.crop.circle.fill") {
                NavigationStackWrapper {
                    AccountView()
                }
            }
        }
    }
}

#Preview {
    PoolTabView()
}
