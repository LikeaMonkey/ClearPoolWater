//
//  LoadableView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 19.11.24.
//

import SwiftUI

struct LoadableView<Content: View>: View {
    let state: ViewState
    let reloadAction: () -> Void
    @ViewBuilder let content: () -> Content

    var body: some View {
        switch state {
        case .success:
            content()

        case .loading:
            ProgressView()
                .controlSize(.extraLarge)

        case .failure:
            ErrorView(action: reloadAction)
        }
    }
}

#Preview {
    LoadableView(state: .success) {
    } content: {
        Text("Hello, World!")
    }
    LoadableView(state: .loading) {
    } content: {
        Text("Hello, World!")
    }
    LoadableView(state: .failure) {
    } content: {
        Text("Hello, World!")
    }
}
