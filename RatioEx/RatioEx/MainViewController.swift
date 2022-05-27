//
//  ViewController.swift
//  RatioEx
//
//  Created by minimani on 2022/05/27.
//

import UIKit

import SnapKit

class MainViewController: UIViewController {
    
    let ratio = UIScreen.main.bounds.height / 812

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        let redViewHeight = ratio * 500
        let blueViewHeight = ratio * 100
        let greenViewHeight = ratio * 300
        
        
        let redViewLabel = UILabel()
        redViewLabel.text = "첫번째 뷰"
        self.view.addSubview(redViewLabel)
        redViewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        let redView = UIView()
        redView.backgroundColor = .red
        self.view.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.top.equalTo(redViewLabel.snp.bottom).inset(-10)
            make.left.right.equalToSuperview()
            make.height.equalTo(redViewHeight)
        }
        
        let blueViewLabel = UILabel()
        blueViewLabel.text = "두번째 뷰"
        self.view.addSubview(blueViewLabel)
        blueViewLabel.snp.makeConstraints { make in
            make.top.equalTo(redView.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        self.view.addSubview(blueView)
        blueView.snp.makeConstraints { make in
            make.top.equalTo(blueViewLabel.snp.bottom).inset(-10)
            make.left.right.equalToSuperview()
            make.height.equalTo(blueViewHeight)
        }
        
        let greenViewLabel = UILabel()
        greenViewLabel.text = "세번째 뷰"
        self.view.addSubview(greenViewLabel)
        greenViewLabel.snp.makeConstraints { make in
            make.top.equalTo(blueView.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        self.view.addSubview(greenView)
        greenView.snp.makeConstraints { make in
            make.top.equalTo(greenViewLabel.snp.bottom).inset(-10)
            make.left.right.equalToSuperview()
            make.height.equalTo(greenViewHeight)
        }
    }


}

