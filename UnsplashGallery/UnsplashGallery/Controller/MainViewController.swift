//
//  ViewController.swift
//  UnsplashGallery
//
//  Created by minimani on 2022/05/30.
//

import UIKit

import SnapKit

class MainViewController: UIViewController {
    
    let galleryCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    var photoArray: [Photos] = []
    var page = 1
    var hasNextPage = true
    var isRequesting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        getPhotos(page: page)
    }
    
    func getPhotos(page: Int) {
            
        if isRequesting {
            return
        }
        
        if page == 45 {
            hasNextPage = false
            return
        }
        
        let parameter = ["page": "\(page)"]
        isRequesting = true
        Networking.shared.getPhotos(parameter: parameter) { response in
            self.photoArray.append(contentsOf: response)
            DispatchQueue.main.async { [self] in
                galleryCollectionView.reloadData()
                isRequesting = false
            }
        }
    }
    
    func setUpView() {
        self.view.backgroundColor = .white
        
        galleryCollectionView.register(GalleryCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIdentifier")
        galleryCollectionView.delegate = self
        galleryCollectionView.dataSource = self
        let flowLayout = galleryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        flowLayout.estimatedItemSize = .zero
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        self.view.addSubview(galleryCollectionView)
        galleryCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return photoArray.count
        } else {
            if hasNextPage {
                return 1
            } else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let photo = photoArray[indexPath.row].urls
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! GalleryCollectionViewCell
            cell.imageView.imageDownload(url: photo.thumb)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
            
            let indicator = UIActivityIndicatorView()
            indicator.style = .medium
            indicator.color = .black
            cell.contentView.addSubview(indicator)
            indicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            page += 1
            indicator.startAnimating()
            getPhotos(page: page)
            
            return cell
        }
    }
}
