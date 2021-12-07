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

final class EditViewController: UIViewController {
    
    // MARK: - Model
    
    var originalText = "" {
        didSet { editText = originalText }
    }
    
    var editText = "" {
        didSet { viewIfLoaded?.setNeedsLayout() }
    }
    
    var hasChanges: Bool {
        return originalText != editText
    }
    
    // MARK: - Delegate
    
    weak var delegate: EditViewControllerDelegate?
    
    // MARK: - View

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
    }
    
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
    
    // MARK: - @IBAction
    @IBAction func cancel(_ sender: Any) {
        delegate?.editViewControllerDidCancel(self)
    }
    
    @IBAction func save(_ sender: Any) {
        if let sheet = navigationController?.sheetPresentationController {
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = .medium
            }
        }
        delegate?.editViewControllerDidFinish(self)
    }
    
    // MARK: - Cancellation Confirmation
    
    func confirmCancel(showingSave: Bool) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if showingSave {
            alert.addAction(UIAlertAction(title: "Save", style: .default) { _ in
                self.delegate?.editViewControllerDidFinish(self)
            })
        }
        
        alert.addAction(UIAlertAction(title: "Discard Changes", style: .destructive) { _ in
            self.delegate?.editViewControllerDidCancel(self)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.popoverPresentationController?.barButtonItem = cancelButton
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate
extension EditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        editText = textView.text
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension EditViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        confirmCancel(showingSave: true)
    }
}
