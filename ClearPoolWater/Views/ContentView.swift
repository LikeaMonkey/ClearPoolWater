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
        #if DEBUG
            // LoginView()
            PoolTabView()
        #else
            if Auth.shared.loggedIn {
                PoolTabView()
            } else {
                LoginView()
            }
        #endif
    }
}

#Preview {
    ContentView()
}
