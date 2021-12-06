//
//  EditViewController.swift
//  SheetPresentation-Example
//
//  Created by SHIN YOON AH on 2021/12/07.
//

import UIKit

protocol EditViewControllerDelegate: AnyObject {
    func editViewControllerDidCancel(_ editViewController: EditViewController)
    func editViewControllerDidFinish(_ editViewController: EditViewController)
}

class EditViewController: UIViewController {
    
    // MARK: - Model
    
    var originalText = "" {
        didSet { editText = originalText}
    }
    
    var editText = "" {
        didSet { viewIfLoaded?.setNeedsLayout()}
    }
    
    var hasChanges: Bool {
        return originalText != editText
    }

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        textView.text = editText
        
        saveButton.isEnabled = hasChanges
        isModalInPresentation = hasChanges
    }
    
    // MARK: - Events
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
