//
//  AccountInfoView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct AccountInfoView: View {
    let email: String
    let role: User.Role

    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                AccountAvatar(initial: email.first ?? "-")

                Text(email)
                    .font(.title)
            }

            AccountPlanView(role: role)

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 40)
    }
}

#Preview {
    AccountInfoView(email: "user@user.com", role: .paidUser)
}
