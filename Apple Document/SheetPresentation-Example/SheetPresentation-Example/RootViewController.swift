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

    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "Edit":
            let navigationController = segue.destination as! UINavigationController
            let editViewController = navigationController.topViewController as! EditViewController
            
            navigationController.presentationController?.delegate = editViewController
            
            editViewController.delegate = self
            editViewController.originalText = text
        default:
            break
        }
    }
    
    // MARK: - EditViewControllerDelegate
    
    func editViewControllerDidCancel(_ editViewController: EditViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func editViewControllerDidFinish(_ editViewController: EditViewController) {
        text = editViewController.editText
        dismiss(animated: true, completion: nil)
    }
}

