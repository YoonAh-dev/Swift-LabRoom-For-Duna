//
//  ViewController.swift
//  TypingAnimationTest
//
//  Created by SHIN YOON AH on 2021/08/07.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.setTyping(text: "안녕하세요 저는 신윤아입니다.\n방탈출을 못해서 너무 속상해요\n기릿기릿기릿 생각해보니 킹받네;")
    }


}

