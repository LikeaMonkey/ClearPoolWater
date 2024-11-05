//
//  LanguagePicker.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 5.11.24.
//

import SwiftUI

struct LanguagePicker: View {
    @AppStorage("language") var language = "en"

    var body: some View {
        Picker(selection: $language) {
            Text("English")
                .tag("en")
            Text("Български")
                .tag("bg")
        } label: {
            HStack {
                Image(systemName: "globe")
                Text("Language")
            }
        }
    }
}

#Preview {
    LanguagePicker()
}
