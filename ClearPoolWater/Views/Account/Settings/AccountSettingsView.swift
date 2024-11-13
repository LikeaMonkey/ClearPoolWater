//
//  AccountSettingsView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct AccountSettingsView: View {
    var body: some View {
        List {
            Section {
                LanguagePicker()
            }

            Section {
                UnitsPicker()
                TemperaturePicker()
            }

            appearanceSection

            Section {
                help
                rateThisApp
                sendFeedback
                reportBug
            }

            Section {
                termsAndConditions
                privacyPolicy
                deleteAccount
            }

            Section {
                clearCacheButton
            }

            Section {
                logOutButton
            }

            appVersionInfo
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(20)
        .contentMargins(.top, 12)
        .navigationTitle("Settings")
        .scrollContentBackground(.hidden)
    }

    private var appearanceSection: some View {
        Section("Appearance") {
            AppearancePicker()
                .listRowBackground(Color.clear)
        }
        .listRowInsets(EdgeInsets())
    }

    private var help: some View {
        NavigationLink {
            Text("TBD")
        } label: {
            HStack {
                Image(systemName: "questionmark.circle")
                Text("Help")
            }
        }
    }

    private var rateThisApp: some View {
        NavigationLink {
            Text("TBD")
        } label: {
            HStack {
                Image(systemName: "star")
                Text("Rate this app")
            }
        }
    }

    private var sendFeedback: some View {
        NavigationLink {
            Text("TBD")
        } label: {
            HStack {
                Image(systemName: "paperplane")
                Text("Send Feedback")
            }
        }
    }

    private var reportBug: some View {
        NavigationLink {
            Text("TBD")
        } label: {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                Text("Report a Bug")
            }
        }
    }

    private var termsAndConditions: some View {
        NavigationLink {
            Text("TBD")
        } label: {
            HStack {
                Image(systemName: "pencil.and.list.clipboard")
                Text("Terms and Conditions")
            }
        }
    }

    private var privacyPolicy: some View {
        NavigationLink {
            Text("TBD")
        } label: {
            HStack {
                Image(systemName: "lock.shield")
                Text("Privacy Policy")
            }
        }
    }

    private var deleteAccount: some View {
        NavigationLink {
            Text("TBD")
        } label: {
            HStack {
                Image(systemName: "delete.forward")
                Text("Delete Account")
            }
        }
    }

    private var clearCacheButton: some View {
        Button {
            URLCache.shared.removeAllCachedResponses()
        } label: {
            HStack {
                Image(systemName: "xmark.bin")
                Text("Clear Cache")
            }
        }
    }

    private var logOutButton: some View {
        Button {
            AuthManager.shared.logout()
        } label: {
            HStack {
                Image(systemName: "arrow.forward")
                Text("Log Out")
            }
        }
        .foregroundColor(.red)
    }

    private var appVersionInfo: some View {
        // TODO: Fix actual version and build
        Text("VERSION 1.0.0 (15)")
            .font(.caption)
            .foregroundColor(.cyan)
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
    }
}

#Preview {
    AccountSettingsView()
}
