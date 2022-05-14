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

/*
 {
     "authors": [
         "掌田津耶乃／著"
     ],
     "contents": "",
     "datetime": "2019-10-01T00:00:00.000+09:00",
     "isbn": " 9784899774983",
     "price": 33120,
     "publisher": "",
     "sale_price": 30810,
     "status": "정상판매",
     "thumbnail": "https://search1.kakaocdn.net/thumb/R120x174.q85/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flbook%2Fimage%2F5179585",
     "title": "PYTHONではじめるIOSプログラミング IOS+PYTHONで數値處理からGUI,ゲ-ム,IOS...",
     "translators": [],
     "url": "https://search.daum.net/search?w=bookpage&bookId=5179585&q=PYTHON%E3%81%A7%E3%81%AF%E3%81%98%E3%82%81%E3%82%8BIOS%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0+IOS%2BPYTHON%E3%81%A7%E6%95%B8%E5%80%A4%E8%99%95%E7%90%86%E3%81%8B%E3%82%89GUI%2C%E3%82%B2-%E3%83%A0%2CIOS%E6%A9%9F%E8%83%BD%E6%93%B4%E5%BC%B5%E3%81%BE%E3%81%A7"
 },
 
 "meta": {
         "is_end": false,
         "pageable_count": 1000,
         "total_count": 1074
     }
 */

struct Book: Codable {
    var documents: [Documents]
    var meta: Meta
}

struct Meta: Codable {
    var isEnd: Bool
    var pageableCount: Int
    var totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}

struct Documents: Codable {
    var authors: [String]
    var contents: String
    var datetime: String
    var isbn: String
    var price: Int
    var publisher: String
    var salePrice: Int
    var status: String
    var thumbnail: String
    var title: String
    var translators: [String]
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case authors
        case contents
        case datetime
        case isbn
        case price
        case publisher
        case salePrice = "sale_price"
        case status
        case thumbnail
        case title
        case translators
        case url
    }
}

//struct Book: Codable {
//    var idx: String
//    var bookImageUrl: String
//    var bookTitle: String
//    var bookDescription: String
//
//    enum CodingKeys: String, CodingKey {
//        case idx
//        case bookImageUrl = "book_image_url"
//        case bookTitle = "book_title"
//        case bookDescription = "book_description"
//    }
//}


