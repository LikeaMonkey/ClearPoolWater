//
//  AccountInfoView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct AccountInfoView: View {
    let email: String
    let plan: String

    init(email: String, role: User.Role) {
        self.email = email
        plan = (role == .paidUser ? "Pro Plan" : "Free Plan")
    }

    var body: some View {
        HStack {
            accountIcon

            VStack(alignment: .leading, spacing: 10) {
                Text(email)
                Text(plan)
            }

            Spacer()

            Button("Edit") {
                // TODO: Implement
            }
            .buttonStyle(.bordered)
        }
        .padding(30)
    }

    private var accountIcon: some View {
        Image(systemName: "person.crop.circle.fill")
            .font(.largeTitle)
            .foregroundStyle(.blue)
            .padding(.trailing, 10)
    }
}

#Preview {
    AccountInfoView(email: "user@user.com", role: .paidUser)
}
