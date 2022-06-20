//
//  GalleryCollectionViewCell.swift
//  UnsplashGallery
//
//  Created by minimani on 2022/05/31.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
    }
    
    func setUpCell() {
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleToFill
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
