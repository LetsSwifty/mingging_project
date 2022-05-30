//
//  GalleryCollectionViewCell.swift
//  UnsplashGallery
//
//  Created by minimani on 2022/05/31.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
    }
    
    func setUpCell() {
        let testLabel = UILabel()
        testLabel.text = "123"
        self.contentView.addSubview(testLabel)
        testLabel.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
    }
}
