//
//  TestViewController.swift
//  Action-Extension-Shared
//
//  Created by SHIN YOON AH on 2022/01/02.
//

import UIKit
import WebKit

class TestViewController: UIViewController {
    
    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = webView
    }

    func setData(url: String) {
        guard let url = URL(string: url) else {return}
        let request = URLRequest(url: url)
        webView.load(request)
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
