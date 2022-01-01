//
//  ActionViewController.swift
//  Action
//
//  Created by SHIN YOON AH on 2021/11/29.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ActionViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var convertedString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the item[s] we're handling from the extension context.
        let textItem = self.extensionContext!.inputItems[0] as! NSExtensionItem
        let textItemProvider = textItem.attachments![0]
        
        if textItemProvider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
            textItemProvider.loadItem(forTypeIdentifier: kUTTypeText as String,
                                      options: nil,
                                      completionHandler: { (result, error) in
                self.convertedString = result as? String
                if self.convertedString != nil {
                    self.convertedString = self.convertedString!.appending(".")
                    DispatchQueue.main.async {
                        self.textView.text = self.convertedString!
                        print("result")
                        
                    }
                }
            })
        }
    }
    
    @IBAction func done() {
        let returnProvider =
        NSItemProvider(item: convertedString as NSSecureCoding?,
                       typeIdentifier: kUTTypeText as String)
        
        let returnItem = NSExtensionItem()
        
        returnItem.attachments = [returnProvider]
        self.extensionContext!.completeRequest(
            returningItems: [returnItem], completionHandler: nil)
    }
}
