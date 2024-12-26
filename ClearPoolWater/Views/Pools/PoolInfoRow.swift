//
//  PoolInfoRow.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 22.10.24.
//

import SwiftUI

struct PoolInfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
            Spacer()
            Text("\(value)")
                .font(.callout)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    PoolInfoRow(title: "Title", value: "100")
}
