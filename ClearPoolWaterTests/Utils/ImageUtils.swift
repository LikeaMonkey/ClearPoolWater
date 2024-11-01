//
//  ImageUtils.swift
//  ClearPoolWater
//
//  Created by Stanimir Hristov on 1.11.24.
//

import UIKit

struct ImageUtils {
    static func createTestImage(
        width: CGFloat = 100,
        height: CGFloat = 100,
        color: UIColor = .blue
    ) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)

        UIGraphicsBeginImageContext(rect.size)
        defer { UIGraphicsEndImageContext() }

        color.setFill()
        UIRectFill(rect)

        let testImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        return testImage
    }

    static func createTestCGImage(
        width: CGFloat = 100,
        height: CGFloat = 100,
        color: UIColor = .blue
    ) -> CGImage {
        createTestImage(width: width, height: height, color: color).cgImage!
    }
}
