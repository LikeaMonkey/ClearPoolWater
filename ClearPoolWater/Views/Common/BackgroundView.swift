//
//  BackgroundView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 4.11.24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        // Background Gradient for a pool-like appearance
        LinearGradient(
            gradient: Gradient(colors: [
                .poolTopColor.opacity(0.8),  // Custom light blue
                .poolMiddleColor.opacity(0.6),  // Custom mid-blue
                .poolBottomColor.opacity(0.4),  // Custom teal/green
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

extension Color {
    static let poolTopColor = Color(red: 160 / 255, green: 214 / 255, blue: 230 / 255)  // #A0D6E6
    static let poolMiddleColor = Color(red: 91 / 255, green: 192 / 255, blue: 233 / 255)  // #5BC0E9
    static let poolBottomColor = Color(red: 44 / 255, green: 175 / 255, blue: 175 / 255)  // #2CAFAF
}
