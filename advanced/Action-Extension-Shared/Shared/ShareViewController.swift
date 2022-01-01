//
//  ShareViewController.swift
//  Share
//
//  Created by SHIN YOON AH on 2021/11/29.
//

import UIKit
import Social
import MobileCoreServices

final class ShareViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var sharingData:NSExtensionContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configUI() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "새로운 컨텐츠"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelButtonTapped(_:)))
        self.view.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.transform = .identity
        })
        
        button.addTarget(self, action: #selector(shareButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    private func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.hideExtensionWithCompletionHandler(completion: { _ in
            self.sharingData?.completeRequest(returningItems: nil, completionHandler: nil)
        })
    }
    
    @objc
    private func shareButtonTapped(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "MainInterface", bundle: nil).instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        guard let text = textField.text else { return }
        vc.category = text
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func hideExtensionWithCompletionHandler(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.view.transform = CGAffineTransform(translationX: 0, y:self.navigationController!.view.frame.size.height)
        }, completion: completion)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}
