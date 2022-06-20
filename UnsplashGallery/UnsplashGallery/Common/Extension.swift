//
//  Extension.swift
//  UnsplashGallery
//
//  Created by milli on 2022/06/20.
//

import UIKit

import SDWebImage

extension UIImageView {
    func imageDownload(url: String) {
        let url = URL(string: url)
        self.sd_setImage(with: url)
    }
}
