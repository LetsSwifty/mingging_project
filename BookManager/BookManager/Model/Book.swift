//
//  Book.swift
//  BookManager
//
//  Created by minimani on 2022/05/05.
//

import Foundation

/*
 {
     "book_image_url": "",
     "book_title": "",
     "book_description": ""
 }
 */

struct Book: Decodable {
    var bookImageUrl: String
    var bookTitle: String
    var bookDescription: String
    
    enum CodingKeys: String, CodingKey {
        case bookImageUrl = "book_image_url"
        case bookTitle = "book_title"
        case bookDescription = "book_description"
    }
}
