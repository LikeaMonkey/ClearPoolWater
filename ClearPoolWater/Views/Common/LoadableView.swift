//
//  LoadableView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.11.24.
//

import SwiftUI

struct LoadableView<Content: View>: View {
    let state: ViewState
    let reloadAction: (() -> Void)?
    @ViewBuilder let content: () -> Content

    var body: some View {
        switch state {
        case .success:
            content()

        case .loading:
            ProgressView()
                .controlSize(.extraLarge)

        case .failure:
            ErrorView(reloadAction: reloadAction)
        }
    }
}

#Preview {
    LoadableView(state: .success) {
        // Do nothing
    } content: {
        Text("Success")
    }
}
