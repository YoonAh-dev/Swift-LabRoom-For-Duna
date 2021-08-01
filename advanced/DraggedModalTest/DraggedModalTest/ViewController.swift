//
//  ViewController.swift
//  DraggedModalTest
//
//  Created by SHIN YOON AH on 2021/08/01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tappedButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "PresentVC") as? PresentVC else { return }
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
}

