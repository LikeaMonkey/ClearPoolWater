//
//  AccountPlanView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 14.11.24.
//

import SwiftUI

struct AccountPlanView: View {
    let plan: String

    init(role: User.Role) {
        plan = (role == .paidUser ? "Pro" : "Free")
    }

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "medal.star.fill")
                .font(.largeTitle)

            VStack(alignment: .leading) {
                Text("PLAN")
                    .font(.caption)
                Text(plan)
                    .font(.title)
                    .fontWeight(.bold)
            }

            Spacer()

            Button("Change") {
                // TODO: Implement
            }
            .buttonStyle(.bordered)
        }
    }
}
