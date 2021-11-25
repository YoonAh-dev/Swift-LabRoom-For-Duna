//
//  SecondVC.swift
//  PresentStyle
//
//  Created by SHIN YOON AH on 2021/06/21.
//

import UIKit

class SecondVC: UIViewController {
    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var charcter: UIView!
    @IBOutlet weak var characterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        circle.layer.cornerRadius = 25
        charcter.backgroundColor = .clear
        characterImage.image = UIImage(named: "among")
        
        let move = CGAffineTransform(translationX: 0, y: -20)
        let scale = CGAffineTransform(scaleX: 2, y: 2)
        
        let combine = move.concatenating(scale)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            UIView.animate(withDuration: 0.2, animations: {
                self.circle.transform = CGAffineTransform(scaleX: 10, y: 10)
                
                self.charcter.transform = combine
                self.characterImage.transform = combine
            })
        })
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
