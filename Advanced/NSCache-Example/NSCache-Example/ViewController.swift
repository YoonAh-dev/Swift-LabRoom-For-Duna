//
//  ViewController.swift
//  NSCache-Example
//
//  Created by SHIN YOON AH on 2022/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hyungyuImageView: UIImageView!
    @IBOutlet weak var inaeImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hyungyuImageView.backgroundColor = .black
        inaeImageView.backgroundColor = .black
    }
    
    @IBAction func touchUpDownload(_ sender: Any) {
        let hyungyuURL = "https://images.unsplash.com/photo-1655769135684-e35826d4859d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3087&q=80"
        hyungyuImageView.loadImageUrl(hyungyuURL)
        
        let inaeURL = URL(string: "https://avatars.githubusercontent.com/u/26399850?v=4")
        URLSession.shared.dataTask(with: inaeURL!) { data, response, error in
            guard let data = data else { return }
            let image = UIImage(data: data)!
            DispatchQueue.main.async {
                self.inaeImageView.image = image
            }
        }.resume()
    }
    
    @IBAction func clear(_ sender: Any) {
        hyungyuImageView.image = UIImage()
        inaeImageView.image = UIImage()
    }
}
