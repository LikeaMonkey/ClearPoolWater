//
//  CreatePoolView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 13.10.24.
//

import SwiftUI

struct CreatePoolView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = CreatePoolViewModel()

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Pool details")) {
                    TitledView(title: "Name") {
                        TextField("Enter name", text: $viewModel.name)
                            .controlSize(.extraLarge)
                    }

                    TitledView(title: "Water level") {
                        Picker("Water level", selection: $viewModel.waterLevel) {
                            ForEach(0...100, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .pickerStyle(.wheel)
                    }

                    TitledView(title: "Water capacity") {
                        HStack(spacing: 0) {
                            Picker(selection: .constant(3), label: Text("Picker")) {
                                Text("1 lb").tag(1)
                                Text("2 lb").tag(2)
                                Text("3 lb").tag(3)
                                Text("4 lb").tag(4)
                                Text("5 lb").tag(5)
                                Text("6 lb").tag(6)
                            }
                            .pickerStyle(.wheel)
                            .clipShape(.rect.offset(x: -16))
                            .padding(.trailing, -16)

                            Picker(selection: .constant(3), label: Text("Picker")) {
                                Text("1 oz").tag(1)
                                Text("2 oz").tag(2)
                                Text("3 oz").tag(3)
                                Text("4 oz").tag(4)
                                Text("5 oz").tag(5)
                                Text("6 oz").tag(6)
                            }
                            .pickerStyle(.wheel)
                            .clipShape(.rect.offset(x: 16))
                            .padding(.leading, -16)
                        }
                    }

                    Picker("Filter system", selection: $viewModel.filterType) {
                        ForEach(Pool.FilterType.allCases) { type in
                            Text(type.toString())
                                .tag(type)
                        }
                    }
                }
            }

            Button("Create") {
                Task {
                    await viewModel.addNewPool()
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    CreatePoolView()
}
