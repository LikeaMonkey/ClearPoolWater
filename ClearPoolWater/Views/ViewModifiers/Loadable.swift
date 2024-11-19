//
//  Loadable.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 19.11.24.
//

import SwiftUI

struct Loadable: ViewModifier {
    let state: ViewState
    let reloadAction: (() -> Void)?

    func body(content: Content) -> some View {
        switch state {
        case .success:
            content

        case .loading:
            ProgressView()
                .controlSize(.extraLarge)

        case .failure:
            ErrorView(reloadAction: reloadAction)
        }
    }
}

extension View {
    func loadable(
        state: ViewState,
        reloadAction: (() -> Void)? = nil
    ) -> some View {
        modifier(Loadable(state: state, reloadAction: reloadAction))
    }
}
