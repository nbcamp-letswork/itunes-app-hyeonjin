//
//  UICollectionViewCell+Extension.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/15/25.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
