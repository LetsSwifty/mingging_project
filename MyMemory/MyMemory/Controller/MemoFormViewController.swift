//
//  MemoFormViewController.swift
//  MyMemory
//
//  Created by minimani on 2022/08/11.
//

import UIKit

class MemoFormViewController: UIViewController {

    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    var subject: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
    }
    
    // 저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        // 내용을 입력하지 않았을 경우 경고
        guard self.contents.text.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        // MemoData 객체를 생성하고 데이터를 담는다.
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdata = Date()
        
        // 앱 델리게이트 객체를 읽어온 다음 memolist 배열에 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        print(appDelegate.memolist)
        
        // 작성폼 화면 종료, 이전 화면으로 되돌아가기
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // 카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        // 이미지 피커 인스턴스 생성
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // 이미지 피커 화면 표시
        self.present(picker, animated: false, completion: nil)
    }
}

extension MemoFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 사용자가 이미지를 선택하면 자동으로 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택된 이미지를 미리보기에 출력
        self.preview.image = info[.editedImage] as? UIImage
        
        // 이미지 피커 닫기
        picker.dismiss(animated: false, completion: nil)
    }
}

extension MemoFormViewController: UITextViewDelegate {
    // 사용자가 텍스트 뷰에 뭔가를 입력하면 자동으로 호출
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        let length = ((contents.length > 15 ? 15 : contents.length))
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        // 내비게이션 타이틀에 표시
        self.navigationItem.title = self.subject
    }
}
