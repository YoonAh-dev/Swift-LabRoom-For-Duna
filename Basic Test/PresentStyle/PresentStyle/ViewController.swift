//
//  ViewController.swift
//  PresentStyle
//
//  Created by SHIN YOON AH on 2021/06/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var charcter: UIView!
    
    @IBOutlet weak var charcterImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        circle.layer.cornerRadius = 25
        
        charcter.backgroundColor = .clear
        charcterImage.image = UIImage(named: "among")
    }

    @IBAction func touchUpPresent(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SecondVC") as! SecondVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
}

extension UIViewController {

    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)

        present(viewControllerToPresent, animated: false)
    }

    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)

        dismiss(animated: false)
    }
}
