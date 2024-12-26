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
    private let viewModel: DeviceDetailViewModel

    init(pool: Pool, waterStatus: WaterStatus, device: CBPeripheral) {
        viewModel = DeviceDetailViewModel(pool: pool, waterStatus: waterStatus, device: device)
    }

    var body: some View {
        VStack {
            List {
                phSection
            }
            updateButton
        }
        .navigationTitle(viewModel.navigationTitle)
        .onDisappear {
            viewModel.stopTemperatureUpdates()
        }
    }

    private var phSection: some View {
        Section {
            HStack {
                Text(viewModel.phText)
                    .font(.headline)
                Spacer()
                if !viewModel.isReady {
                    ProgressView()
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        } header: {
            Text("pH")
        } footer: {
            if viewModel.isReady {
                Text("Last updated: \(viewModel.lastUpdated)")
            } else {
                Text("Please wait for device to prepare and gather enough data")
            }
        }
    }

    private var updateButton: some View {
        Button {
            Task {
                await viewModel.updateWaterStatus()
                dismiss()
                dismiss()
            }
        } label: {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Text("Update")
                    .font(.title2)
                    .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .cornerRadius(Constants.cornerRadius)
        .disabled(!viewModel.isReady)
        .padding()
    }
}
