//
//  RootViewController.swift
//  SheetPresentation-Example
//
//  Created by SHIN YOON AH on 2021/12/06.
//

import UIKit

final class RootViewController: UIViewController, EditViewControllerDelegate {
    
    // MARK: - Model
    
    var text = "Hello World!" {
        didSet { viewIfLoaded?.setNeedsLayout() }
    }
    
    // MARK: - View
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillLayoutSubviews() {
        textView.text = text
    }
    
    // MARK: - EditViewControllerDelegate
    
    func editViewControllerDidCancel(_ editViewController: EditViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func editViewControllerDidFinish(_ editViewController: EditViewController) {
        text = editViewController.editText
//        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickEdit(_ sender: Any) {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Navi")
        let editViewController = navigationController.children.first as! EditViewController
        
        editViewController.delegate = self
        editViewController.originalText = text
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        
        present(navigationController, animated: true, completion: nil)
    }
}

