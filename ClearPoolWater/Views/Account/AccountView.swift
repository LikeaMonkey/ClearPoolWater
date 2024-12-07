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
        AccountInfoView(
            email: viewModel.user?.email ?? "-",
            role: viewModel.user?.role ?? .user
        )
        .loadable(state: viewModel.state) {
            Task {
                await viewModel.fetchAccount()
            }
        }
        .fancyBackground()
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    // TODO: Implement
                } label: {
                    Image(systemName: "pencil")
                }
            }

            ToolbarItem {
                NavigationLink {
                    AccountSettingsView()
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .task {
            await viewModel.fetchAccount()
        }
    }
}

#Preview {
    AccountView()
}
