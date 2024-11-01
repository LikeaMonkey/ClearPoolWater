//
//  ContentView.swift
//  Test - Test 1
//
//  Created by Stanimir Hristov on 4.07.24.
//

import SwiftUI

/// Main ContentView of the app
struct ContentView: View {
    var body: some View {
        if AuthManager.shared.isLoggedIn {
            PoolTabView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
