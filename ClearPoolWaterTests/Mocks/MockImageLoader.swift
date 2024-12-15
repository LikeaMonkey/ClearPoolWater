//
//  MockImageLoader.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 14.11.24.
//

import PhotosUI
import SwiftUI

@testable import ClearPoolWater

final class MockImageLoader: ImageLoading {
    let image: UIImage?
    let data: Data?

    init(image: UIImage? = nil) {
        self.image = image
        self.data = image?.pngData()
    }

    func loadImage(from data: Data) -> UIImage? { image }
    func loadImageData(from item: PhotosPickerItem) async -> Data? { data }
    func loadImageData(from image: UIImage) -> Data? { data }
}
