//
//  BetweenViewController.swift
//  Action-Extension-Shared
//
//  Created by SHIN YOON AH on 2022/01/01.
//

import UIKit

@objc(BetweenViewController)
class BetweenViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBetweenViewController()
    }
    
    private func setBetweenViewController() {
        let shareVC = UIStoryboard(name: "MainInterface", bundle: nil).instantiateViewController(withIdentifier: "ShareViewController") as! ShareViewController
        shareVC.sharingData = self.extensionContext
        let nav = UINavigationController(rootViewController: shareVC)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: false)
    }
    
}
