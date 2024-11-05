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
                planDetailsRow
                UnitsPicker()
                TemperaturePicker()
                LanguagePicker()
                DarkModeToggle()
            }

            Section {
                clearCacheButton
                reportBugButton
                sendFeedbackButton
            }

            Section {
                logOutButton
            }

            PoliciesView()
                .listRowBackground(Color.clear)
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(20)
    }

    private var planDetailsRow: some View {
        NavigationLink {
            // TODO: Implement
            Text("TBD")
        } label: {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)
            Text("Plan Details")
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

    private var reportBugButton: some View {
        Button {
            // TODO: Implement
        } label: {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                Text("Report a Bug")
            }
        }
    }

    private var sendFeedbackButton: some View {
        Button {
            // TODO: Implement
        } label: {
            HStack {
                Image(systemName: "paperplane")
                Text("Send Feedback")
            }
        }
    }
}

#Preview {
    AccountSettingsView()
}
