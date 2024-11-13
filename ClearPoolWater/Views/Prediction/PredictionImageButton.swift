//
//  PredictionImageButton.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 7.11.24.
//

import PhotosUI
import SwiftUI

public struct PredictionImageButton: View {
    @Binding var image: Image?
    @Binding var selectedPhoto: PhotosPickerItem?

    @State private var isConfirmationDialogPresented = false
    @State private var isPhotosPickerPresented = false

    public var body: some View {
        Button {
            isConfirmationDialogPresented.toggle()
        } label: {
            if let image {
                image
                    .resizable()
                    .frame(width: 300, height: 300)
            } else {
                noImageView
                    .frame(width: 300, height: 300)
            }
        }
        .background(.regularMaterial)
        .cornerRadius(25)
        .confirmationDialog(
            "Select a pool photo",
            isPresented: $isConfirmationDialogPresented,
            titleVisibility: .visible
        ) {
            Button("Camera") {
                //TODO: Implement
            }

            Button("Photo Library") {
                isPhotosPickerPresented.toggle()
            }
        }
        .photosPicker(
            isPresented: $isPhotosPickerPresented,
            selection: $selectedPhoto,
            matching: .images
        )
    }

    private var noImageView: some View {
        VStack(spacing: 10) {
            Image(systemName: "photo.badge.plus")
                .font(.title2)
            Text("Tap to Add Photo")
                .font(.title3)
        }
    }
}

#Preview {
    PredictionImageButton(image: .constant(nil), selectedPhoto: .constant(nil))
}
