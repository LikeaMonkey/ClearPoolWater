//
//  PoliciesView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct PoliciesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("© 2024 Clear Pool Water")
                Spacer()
                Text("Version 1.0.0")
                    .foregroundColor(.gray)
            }
            .font(.footnote)

            HStack(spacing: 10) {
                TermsAndConditionsButton()
                Button("Privacy Policy") {
                    // TODO: Implement
                }
            }
            .controlSize(.mini)
            .font(.footnote)
        }
    }
}

#Preview {
    PoliciesView()
}
