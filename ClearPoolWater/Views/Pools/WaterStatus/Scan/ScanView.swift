//
//  ScanView.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 8.12.24.
//

import CoreBluetooth
import SwiftUI

struct ScanView: View {
    let pool: Pool
    let waterStatus: WaterStatus

    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ScanViewModel()

    var body: some View {
        List {
            nearbyDevicesSection
        }
        .navigationTitle("Devices")
        .navigationDestination(isPresented: $viewModel.showConnectedDetail) {
            if let device = viewModel.connectedDevice {
                DeviceDetailView(pool: pool, waterStatus: waterStatus, device: device)
            }
        }
        .onAppear {
            viewModel.disconnect()
        }
        .toolbar {
            Button("Done") {
                dismiss()
            }
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
    ScanView(
        pool: .example,
        waterStatus: WaterStatus(id: 1, ph: 7.2, chlorine: 1)
    )
}
