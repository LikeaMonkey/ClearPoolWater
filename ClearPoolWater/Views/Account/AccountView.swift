//
//  AccountView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 11.10.24.
//

import SwiftUI

struct AccountView: View {
    @State private var viewModel = AccountViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.isLoading {
                ProgressView()
            } else {
                AccountInfoView(
                    email: viewModel.user?.email ?? "-",
                    role: viewModel.user?.role ?? .user
                )
                AccountSettingsView()
            }
        }
        .navigationTitle("Account")
        .task {
            await viewModel.fetchAccount()
        }
    }
}

#Preview {
    AccountView()
}
