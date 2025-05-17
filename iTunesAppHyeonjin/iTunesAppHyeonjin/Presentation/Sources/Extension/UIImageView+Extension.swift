//
//  UIImageView+Extension.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/15/25.
//

import UIKit

extension UIImageView {
    func loadImage(urlString: String) {
        Task { [weak self] in
            guard let self, let url = URL(string: urlString) else { return }
            guard let (data, _) = try? await URLSession.shared.data(from: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            self.image = image
        }
    }
}
