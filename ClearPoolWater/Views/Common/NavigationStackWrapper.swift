//
//  NavigationStackWrapper.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.11.24.
//

import SwiftUI

struct NavigationStackWrapper<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    @ViewBuilder let content: () -> Content

    var body: some View {
        NavigationStack {
            content()
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        }
        .toolbarBackground(backgroundColor, for: .tabBar)
    }

    private var backgroundColor: Color {
        colorScheme == .dark ? .backgroundBottomDark : .backgroundBottom
    }
}

#Preview {
    NavigationStackWrapper {
        Text("Preview")
    }
}
