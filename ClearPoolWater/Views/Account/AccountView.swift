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
        LoadableView(state: viewModel.state) {
            Task {
                await viewModel.fetchAccount()
            }
        } content: {
            AccountInfoView(
                email: viewModel.user!.email,
                role: viewModel.user!.role
            )
        }
        .fancyBackground()
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            editToolbarItem
            settingsToolbarItem
        }
        .task {
            await viewModel.fetchAccount()
        }
    }

    private var editToolbarItem: some ToolbarContent {
        ToolbarItem {
            Button {
                // TODO: Implement
            } label: {
                Image(systemName: "pencil")
            }
        }
    }

    private var settingsToolbarItem: some ToolbarContent {
        ToolbarItem {
            NavigationLink {
                AccountSettingsView()
            } label: {
                Image(systemName: "gear")
            }
        }
    }
}

#Preview {
    AccountView()
}
