//
//  Singleton.swift
//  BookManager
//
//  Created by minimani on 2022/05/06.
//

import UIKit

class Singleton {
    static let shared = Singleton()
    
    let indicatorView = UIView()
    let indicator = UIActivityIndicatorView()

    func startLoading(view: UIView) {
        indicatorView.frame.size = CGSize(width: 50, height: 50)
        indicatorView.layer.cornerRadius = 5
        indicatorView.backgroundColor = .black.withAlphaComponent(0.5)
        view.addSubview(indicatorView)
        indicatorView.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
      
        indicator.style = .medium
        indicator.tintColor = .white
        indicator.color = .white
        indicatorView.addSubview(indicator)
        indicator.center = CGPoint(x: indicatorView.frame.width / 2, y: indicatorView.frame.height / 2)
        indicator.startAnimating()
    }
    
    func stopLoading() {
        indicator.stopAnimating()
        indicatorView.removeFromSuperview()
    }
}
