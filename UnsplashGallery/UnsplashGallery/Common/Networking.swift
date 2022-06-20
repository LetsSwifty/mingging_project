//
//  Networking.swift
//  UnsplashGallery
//
//  Created by milli on 2022/06/20.
//

import Foundation

import Alamofire

class Networking {
    static var shared = Networking()
    
    func getPhotos(parameter: [String: String], completion: @escaping (_ response: [Photos]) -> ()) {
        let url = "\(APIInfo.hostURL)\(APIInfo.photos)"
        let header: HTTPHeaders = ["Authorization": UserInfo.clientID]
        
        AF.request(url, method: .get, parameters: parameter, headers: header).responseDecodable(of: [Photos].self) { response in
            switch response.result {
            case .success(let result):
                print(result)
                completion(result)
            case .failure(let error):
                print(error)
            }
        }
    }
}
