//
//  UIImageView+Extension.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/15/25.
//

import UIKit

extension UIImageView {
    func loadImage(urlString: String, to size: CGSize, scale: CGFloat) {
        Task { [weak self] in
            guard let self, let url = URL(string: urlString) else { return }
            guard let (data, _) = try? await URLSession.shared.data(from: url) else { return }
            guard let image = downsample(data: data, to: size, scale: scale) else { return }
            
            self.image = image
        }
    }
    
    private func downsample(data: Data, to size: CGSize, scale: CGFloat) -> UIImage? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
                return nil
            }
            
        let maxDimension = max(size.width, size.height) * scale
        let downsampleOptions = [
          kCGImageSourceCreateThumbnailFromImageAlways: true,
          kCGImageSourceShouldCacheImmediately: true,
          kCGImageSourceCreateThumbnailWithTransform: true,
          kCGImageSourceThumbnailMaxPixelSize: maxDimension
        ] as CFDictionary
        
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }

        return UIImage(cgImage: downsampledImage)
    }
}
