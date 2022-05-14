//
//  MainBookTableViewController.swift
//  BookManager
//
//  Created by minimani on 2022/05/05.
//

import UIKit

class MainBookTableViewController: UITableViewController {
    
    var bookArray: [Documents] = []
    var favoriteBookArray: [Documents] = []
    
    let APIKey = "KakaoAK c43c3e26c2d7a8cb6804b7adf7bc0916"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "전체 책 리스트"
        
        // 우측 인셋 제거
        self.tableView.separatorInset = .zero
        self.tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
//        getDummyBookData()
        getBookData()
//        getSaveBookData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSaveBookData()
        self.tableView.reloadData()
    }
    
    @objc func selectFavoriteButton(sender: UIButton) {

        let book = bookArray[sender.tag]

        if UserDefaults.standard.bool(forKey: "\(book.isbn)") {
            UserDefaults.standard.set(false, forKey: "\(book.isbn)")
            sender.setImage(UIImage(named: "favorite_ic"), for: .normal)

            favoriteBookArray = favoriteBookArray.filter { $0.isbn != book.isbn }

        } else {
            UserDefaults.standard.set(true, forKey: "\(book.isbn)")
            sender.setImage(UIImage(named: "favorite_select_ic"), for: .normal)

            favoriteBookArray.append(book)
        }


        // 즐겨찾기 한 값 저장
        do {
            let favoriteBookDataArray = try JSONEncoder().encode(favoriteBookArray)
            UserDefaults.standard.set(favoriteBookDataArray, forKey: "favoriteBookArray")
        } catch(let error) {
            print(error)
        }
        
    }
    
    func getSaveBookData() {
        favoriteBookArray = []
        if let data = UserDefaults.standard.data(forKey: "favoriteBookArray") {
            do {
                let favoriteBook = try JSONDecoder().decode([Documents].self, from: data)
                favoriteBookArray = favoriteBook
            } catch {
                print("Unable to Decode Favorite Players (\(error))")
            }
        }
    }
    
    func getDummyBookData() {
        guard let data = dummyBookData.data(using: .utf8) else { return }
        do {
            let json = try JSONDecoder().decode(Book.self, from: data)
            bookArray = json.documents
        } catch (let error) {
            print(error)
        }
    }
    
    func getBookData() {
        guard let url = URL(string: "https://dapi.kakao.com/v3/search/book?query=iOS&size=20") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(APIKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 통신 실패
            if let error = error {
                print(error)
                return
            }
            
            // 통신 성공
            do {
                guard let data = data else { return }
                let json = try JSONDecoder().decode(Book.self, from: data)
                self.bookArray = json.documents
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch (let error) {
                print(error)
            }
        }.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let book = bookArray[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? BookTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
    
        print(book.title)
        cell.bookImageView.imageLoad(url: book.thumbnail)
        cell.bookTitleLabel.text = book.title
        cell.bookDescriptionLabel.text = book.contents

        if UserDefaults.standard.bool(forKey: "\(book.isbn)") {
            cell.favoriteButton.setImage(UIImage(named: "favorite_select_ic"), for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "favorite_ic"), for: .normal)
        }
        
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(selectFavoriteButton), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
