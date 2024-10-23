//
//  TitledView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 12.10.24.
//

import SwiftUI

struct TitledView<Content: View>: View {
    let title: LocalizedStringKey
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
            content
        }
    }
}

#Preview {
    TitledView(title: "Title") {
        TextField("Text", text: .constant(""))
    }
}
