//
//  MemoReadViewController.swift
//  MyMemory
//
//  Created by minimani on 2022/08/11.
//

import UIKit

class MemoReadViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    
    // 콘텐츠 데이터를 저장하는 변수
    var param: MemoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        self.img.contentMode = .scaleAspectFill
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdata)!)
        
        self.navigationItem.title = dateString
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
