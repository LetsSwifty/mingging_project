//
//  Extensions.swift
//  BookManager
//
//  Created by minimani on 2022/05/06.
//

import Foundation
import UIKit

extension UIImageView {
    func imageLoad(url: String) {
        guard let imageUrl = URL(string: url) else { return }
        do {
            let data = try Data(contentsOf: imageUrl)
            if let image = UIImage(data: data) {
                self.image = image
            }
        } catch(let error) {
            print(error)
        }
    }
}


