//
//  ErrorView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.11.24.
//

import SwiftUI

struct ErrorView: View {
    let reloadAction: (() -> Void)?

    var body: some View {
        VStack(spacing: 12) {
            Text("Something went wrong. Please check your network connection and try again.")

            if let reloadAction {
                Button("Reload", action: reloadAction)
            }
        }
        .padding()
    }
}

#Preview {
    ErrorView {}
}
