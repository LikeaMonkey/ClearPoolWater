//
//  PhotosImageLoader.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 14.11.24.
//

import PhotosUI
import SwiftUI

final class PhotosImageLoader: ImageLoading {
    func loadImage(from data: Data) -> UIImage? {
        UIImage(data: data)
    }

    func loadImageData(from item: PhotosPickerItem) async -> Data? {
        try? await item.loadTransferable(type: Data.self)
    }

    func loadImageData(from image: UIImage) -> Data? {
        image.pngData()
    }
}
