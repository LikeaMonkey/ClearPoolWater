//
//  ImageLoading.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 14.11.24.
//

import PhotosUI
import SwiftUI

@MainActor
protocol ImageLoading {
    func loadImage(from data: Data) -> UIImage?
    func loadImageData(from item: PhotosPickerItem) async -> Data?
    func loadImageData(from image: UIImage) -> Data?
}
