//
//  ScanView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 8.12.24.
//

import CoreBluetooth
import SwiftUI

struct ScanView: View {
    @State private var viewModel = ScanViewModel()

    var body: some View {
        VStack {
            List {
                nearbyDevicesSection
            }
        }
        .navigationTitle("Devices")
        .navigationDestination(isPresented: $viewModel.showConnectedDetail) {
            if let device = viewModel.connectedDevice {
                DeviceDetailView(device: device)
            }
        }
        .onAppear {
            viewModel.disconnect()
        }
    }

    private var nearbyDevicesSection: some View {
        Section {
            ForEach(viewModel.devices, id: \.self) { device in
                row(for: device)
            }
        } header: {
            HStack {
                Text("Nearby devices")
                Spacer()
                ProgressView()
            }
        }
    }

    private func row(for device: CBPeripheral) -> some View {
        HStack {
            Text(device.name ?? "N/A")
                .font(.headline)
            Spacer()
            Button("Connect") {
                viewModel.connect(to: device)
            }
        }
    }
}

#Preview {
    ScanView()
}
