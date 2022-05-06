//
//  MainBookTableViewController.swift
//  BookManager
//
//  Created by minimani on 2022/05/05.
//

import UIKit

class MainBookTableViewController: UITableViewController {
    
    var bookArray: [Book] = []
    var favoriteBookArray: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "전체 책 리스트"
        
        // 우측 인셋 제거
        self.tableView.separatorInset = .zero
        self.tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
        getDummyBookData()
//        getSaveBookData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getSaveBookData()
        self.tableView.reloadData()
    }
    
    @objc func selectFavoriteButton(sender: UIButton) {

        let book = bookArray[sender.tag]
        
        if UserDefaults.standard.bool(forKey: "\(book.idx)") {
            UserDefaults.standard.set(false, forKey: "\(book.idx)")
            sender.setImage(UIImage(named: "favorite_ic"), for: .normal)
            
            favoriteBookArray = favoriteBookArray.filter { $0.idx != book.idx }
            
        } else {
            UserDefaults.standard.set(true, forKey: "\(book.idx)")
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
                let favoriteBook = try JSONDecoder().decode([Book].self, from: data)
                favoriteBookArray = favoriteBook
            } catch {
                print("Unable to Decode Favorite Players (\(error))")
            }
        }
    }
    
    func getDummyBookData() {
        guard let data = dummyBookData.data(using: .utf8) else { return }
        do {
            let json = try JSONDecoder().decode([Book].self, from: data)
            bookArray = json
        } catch (let error) {
            print(error)
        }
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
        
        cell.bookImageView.imageLoad(url: book.bookImageUrl)
        cell.bookTitleLabel.text = book.bookTitle
        cell.bookDescriptionLabel.text = book.bookDescription
        
        if UserDefaults.standard.bool(forKey: "\(book.idx)") {
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
