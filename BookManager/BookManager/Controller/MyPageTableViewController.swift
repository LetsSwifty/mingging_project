//
//  MyPageTableViewController.swift
//  BookManager
//
//  Created by minimani on 2022/05/05.
//

import UIKit

class MyPageTableViewController: UITableViewController {
    
    let emptyLabel = UILabel()
    
    var favoriteBookArray: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "마이페이지"
        
        self.tableView.separatorInset = .zero
        self.tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        if let data = UserDefaults.standard.data(forKey: "favoriteBookArray") {
            do {
                let favoriteBook = try JSONDecoder().decode([Book].self, from: data)
                favoriteBookArray = favoriteBook
            } catch {
                print("Unable to Decode Favorite Players (\(error))")
            }
        }
        

        emptyLabel.text = "책 목록이 비어있습니다."
        emptyLabel.textColor = .systemGray4
        emptyLabel.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        self.view.addSubview(emptyLabel)
        self.view.bringSubviewToFront(emptyLabel)
        
//        print(favoriteBookArray.isEmpty)
//        print(favoriteBookArray.count)
//        if favoriteBookArray.isEmpty {
//            emptyLabel.isHidden = false
//        } else {
//            emptyLabel.isHidden = true
//        }
    }
    
    @objc func selectFavoriteButton(sender: UIButton) {
        
        let alert = UIAlertController(title: "즐겨찾기 삭제", message: "삭제하시겠습니까?", preferredStyle: .alert)
        let okAnction = UIAlertAction(title: "삭제", style: .cancel) { _ in
            let favoriteBook = self.favoriteBookArray[sender.tag]
            
            if UserDefaults.standard.bool(forKey: "\(favoriteBook.idx)") {
                Singleton.shared.startLoading(view: self.view)
                UserDefaults.standard.set(false, forKey: "\(favoriteBook.idx)")
                
                self.favoriteBookArray = self.favoriteBookArray.filter { $0.idx != favoriteBook.idx }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    Singleton.shared.stopLoading()
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoriteBookArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favoriteBook = favoriteBookArray[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? BookTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        cell.bookImageView.imageLoad(url: favoriteBook.bookImageUrl)
        cell.bookTitleLabel.text = favoriteBook.bookTitle
        cell.bookDescriptionLabel.text = favoriteBook.bookDescription
        
        cell.favoriteButton.setImage(UIImage(named: "favorite_select_ic"), for: .normal)
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(selectFavoriteButton), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
