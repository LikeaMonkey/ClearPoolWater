//
//  ErrorView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.11.24.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let actionTitle: String
    let action: (() -> Void)?

    init(
        errorMessage: String = ErrorMessage.defaultMessage,
        actionTitle: String = "Reload",
        action: (() -> Void)? = nil
    ) {
        self.errorMessage = errorMessage
        self.actionTitle = actionTitle
        self.action = action
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(errorMessage)

            if let action {
                Button(actionTitle, action: action)
            }
        }
        .padding()
    }
}

#Preview {
    ErrorView {}
}
