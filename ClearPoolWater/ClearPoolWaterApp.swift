//
//  ClearPoolWaterApp.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 9.10.24.
//

import SwiftUI

@main
struct ClearPoolWaterApp: App {
    @AppStorage("appearance") private var appearance = Appearance.system

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(appearance.colorScheme)
        }
    }
}
