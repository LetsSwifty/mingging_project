//
//  MyPageViewController.swift
//  BookManager
//
//  Created by minimani on 2022/05/06.
//

import UIKit

class MyPageViewController: UIViewController {

    var favoriteBookArray: [Documents] = []
    var cellHeight: CGFloat = 153
    
    @IBOutlet weak var myPageTableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "마이페이지"
        
        self.myPageTableView.delegate = self
        self.myPageTableView.dataSource = self
        self.myPageTableView.separatorInset = .zero
        self.myPageTableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        getFavoriteBookData()
        
        emptyLabel.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        emptyLabel.textColor = .systemGray4
        if favoriteBookArray.isEmpty {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }
    
    func getFavoriteBookData() {
        if let data = UserDefaults.standard.data(forKey: "favoriteBookArray") {
            do {
                let favoriteBook = try JSONDecoder().decode([Documents].self, from: data)
                favoriteBookArray = favoriteBook
            } catch {
                print("Unable to Decode Favorite Players (\(error))")
            }
        }
    }
    
    @objc func selectFavoriteButton(sender: UIButton) {
        
        let alert = UIAlertController(title: "즐겨찾기 삭제", message: "삭제하시겠습니까?", preferredStyle: .alert)
        let okAnction = UIAlertAction(title: "삭제", style: .cancel) { _ in
            let favoriteBook = self.favoriteBookArray[sender.tag]
            
            if UserDefaults.standard.bool(forKey: "\(favoriteBook.isbn)") {
                Singleton.shared.startLoading(view: self.view)
                UserDefaults.standard.set(false, forKey: "\(favoriteBook.isbn)")

                self.favoriteBookArray = self.favoriteBookArray.filter { $0.isbn != favoriteBook.isbn }

                self.myPageTableView.reloadData()

                Singleton.shared.stopLoading()

                if self.favoriteBookArray.isEmpty {
                    self.emptyLabel.isHidden = false
                } else {
                    self.emptyLabel.isHidden = true
                }
            }
            
            // 즐겨찾기 한 값 저장
            do {
                let favoriteBookDataArray = try JSONEncoder().encode(self.favoriteBookArray)
                UserDefaults.standard.set(favoriteBookDataArray, forKey: "favoriteBookArray")
            } catch(let error) {
                print(error)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alert.addAction(okAnction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: false, completion: nil)
    }

}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteBookArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteBook = favoriteBookArray[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? BookTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.bookImageView.imageLoad(url: favoriteBook.thumbnail)
        cell.bookTitleLabel.text = favoriteBook.title
        cell.bookDescriptionLabel.text = favoriteBook.contents
        
        cell.favoriteButton.setImage(UIImage(named: "favorite_select_ic"), for: .normal)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(selectFavoriteButton), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
}
