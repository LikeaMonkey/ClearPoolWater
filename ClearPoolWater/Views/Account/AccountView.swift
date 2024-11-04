//
//  AccountView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import SwiftUI

struct AccountView: View {
    @Environment(Model.self) private var model

    var body: some View {
        VStack(spacing: 15) {
            Text(model.user?.email ?? "No email")
            Text(model.user?.role.rawValue ?? "No role")

            #if DEBUG
                Button("DEBUG: Clean URL Cache") {
                    URLCache.shared.removeAllCachedResponses()
                }
            #endif

            Button {
                AuthManager.shared.logout()
            } label: {
                Text("Logout")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(40)
    }
}

#Preview {
    AccountView()
        .environment(Model())
}
