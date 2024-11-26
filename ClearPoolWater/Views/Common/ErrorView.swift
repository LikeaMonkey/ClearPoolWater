//
//  ErrorView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.11.24.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: LocalizedStringKey
    let reloadAction: (() -> Void)?

    init(
        errorMessage: LocalizedStringKey = Constants.defaultErrorMessage,
        reloadAction: (() -> Void)? = nil
    ) {
        self.errorMessage = errorMessage
        self.reloadAction = reloadAction
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(errorMessage)

            if let reloadAction {
                Button("Reload", action: reloadAction)
            }
        }
        .padding()
    }
}

extension ErrorView {
    struct Constants {
        static let defaultErrorMessage: LocalizedStringKey =
            "Something went wrong. Please check your network connection and try again."
    }
}

#Preview {
    ErrorView {}
}
