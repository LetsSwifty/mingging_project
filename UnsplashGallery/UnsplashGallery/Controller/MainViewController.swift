//
//  ViewController.swift
//  UnsplashGallery
//
//  Created by minimani on 2022/05/30.
//

import UIKit

import SnapKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView() {
        self.view.backgroundColor = .white
        
        let galleryCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        galleryCollectionView.register(GalleryCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIdentifier")
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        self.view.addSubview(galleryCollectionView)
        galleryCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! GalleryCollectionViewCell
        
        return cell
    }
    
        
}
