//
//  ClearPoolWaterApp.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 9.10.24.
//

import SwiftUI

@main
struct ClearPoolWaterApp: App {
    @State private var model = Model()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environment(model)
    }
}
