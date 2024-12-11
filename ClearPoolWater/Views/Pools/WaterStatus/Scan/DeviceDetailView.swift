//
//  DeviceDetailView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 8.12.24.
//

import CoreBluetooth
import SwiftUI

struct DeviceDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: DeviceDetailViewModel

    init(device: CBPeripheral) {
        viewModel = DeviceDetailViewModel(device: device)
    }

    var body: some View {
        VStack {
            List {
                temperatureSection
            }
            disconnectButton
        }
        .navigationTitle(viewModel.navigationTitle)
    }

    private var temperatureSection: some View {
        Section("Temperature") {
            HStack {
                if viewModel.isDeviceReady {
                    temperatureText
                } else {
                    ProgressView()
                }

                Spacer()
                updateTemperatureButton
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
    }

    private var temperatureText: some View {
        Text("\(viewModel.temperature?.formatted() ?? "-") °C")
            .font(.title)
    }

    private var updateTemperatureButton: some View {
        Button("Update") {
            // TODO: Update pool temperature
        }
        .disabled(viewModel.temperature == nil)
    }

    private var disconnectButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Disconnect")
                .font(.title2)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding()
    }
}
