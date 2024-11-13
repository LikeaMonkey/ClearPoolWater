//
//  BackgroundView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 4.11.24.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        LinearGradient(
            gradient: Gradient(
                colors: colorScheme == .dark ? darkColors : lightColors
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private var lightColors: [Color] {
        [.backgroundTop, .backgroundMiddle, .backgroundBottom]
    }

    private var darkColors: [Color] {
        [.backgroundTopDark, .backgroundMiddleDark, .backgroundBottomDark]
    }
}

#Preview {
    BackgroundView()
}
