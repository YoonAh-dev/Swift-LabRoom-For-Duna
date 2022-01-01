//
//  ViewController.swift
//  Action-Extension-Shared
//
//  Created by SHIN YOON AH on 2021/11/29.
//

import UIKit
import SafariServices
import UserNotifications
import WebKit

final class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private let webView = WKWebView()
    private var notificationServices = 1
    private let italicFont = UIFont.italicSystemFont(ofSize: 18)
    private lazy var linkAttributes: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.single.rawValue,
        .foregroundColor: UIColor.green,
        .font: italicFont
    ]
    
    override func viewDidLoad() {
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserDefaults()
    }
    
    private func configUI() {
        memoLabel.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(fixedLabelTapped(_:))
        )
        memoLabel.addGestureRecognizer(recognizer)
    }

    
    private func setUserDefaults() {
        if let userDefaults = UserDefaults(suiteName: "group.com.tiekle.Action-Extension-Shared.Share") {
            print("userDefaults", userDefaults)
            
            if let imgData = userDefaults.object(forKey: "image") as? NSData {
                print("imageData!@#@!#$!@!@$!@ : ", imgData)
                if let image = UIImage(data: imgData as Data) {
                    imageView.image = image
                }
            }
            
            if let text = userDefaults.string(forKey: "text") {
                textLabel.text = text
            }
            
            if let memo = userDefaults.string(forKey: "memo") {
                memoLabel.text = memo
                let attributedString = NSMutableAttributedString(string: memo)
                attributedString.setAttributes(linkAttributes, range: NSMakeRange(0, attributedString.length))
                memoLabel.attributedText = attributedString
            }
            
            userDefaults.set(false, forKey: "inapp")
        }
    }
    
    @objc
    private func fixedLabelTapped(_ sender: UITapGestureRecognizer) {
        if let url = memoLabel.text {
            present(url: url)
//            let vc = storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
//            vc.setData(url: url)
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func present(url string: String) {
        if let url = URL(string: string) {
            let viewController = SFSafariViewController(url: url)
            if let userDefaults = UserDefaults(suiteName: "group.com.tiekle.Action-Extension-Shared.Share") {
                userDefaults.set(true, forKey: "inapp")
            }
            viewController.delegate = self
            present(viewController, animated: true)
        }
    }
    
    @objc
    private func touchUpFinish() {
        
    }
}

extension ViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        if let userDefaults = UserDefaults(suiteName: "group.com.tiekle.Action-Extension-Shared.Share") {
            userDefaults.set(false, forKey: "inapp")
        }
    }
}
