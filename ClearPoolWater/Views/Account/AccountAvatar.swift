//
//  AccountAvatar.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.11.24.
//

import SwiftUI

struct AccountAvatar: View {
    let initial: String

    init(initial: Character) {
        self.initial = initial.uppercased()
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.accentColor)
                .strokeBorder(.white, lineWidth: 4)

            Text(initial)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(width: 100, height: 100)
    }
}

#Preview {
    AccountAvatar(initial: Character("S"))
}
