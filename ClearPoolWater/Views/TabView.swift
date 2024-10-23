//
//  TabView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import SwiftUI

//enum PoolTab: Hashable {
//    case pools
//    case calculator
//    case photo
//    case account
//}

struct PoolTabView: View {
    // @State private var selectedTab = PoolTab.pools

    var body: some View {
        TabView {
            Tab("Pools", systemImage: "figure.pool.swim.circle") {
                NavigationStack {
                    PoolsView()
                }
            }

            Tab("Calculator", systemImage: "plus.forwardslash.minus") {
                PoolCalculatorView()
            }

            Tab("Photo", systemImage: "photo") {
                PoolPhotoView()
            }

            Tab("Account", systemImage: "person.crop.circle.fill") {
                AccountView()
            }
        }
    }
}

#Preview {
    PoolTabView()
}
