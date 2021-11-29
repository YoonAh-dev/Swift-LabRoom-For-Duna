//
//  ShareViewController.swift
//  Share
//
//  Created by SHIN YOON AH on 2021/11/29.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        if contentText.isEmpty {
            return false
        }
        
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        let item = SLComposeSheetConfigurationItem()!
        item.title = "Miraclone"
        item.value = "Coding"
        item.tapHandler = {
            let viewController = ShareViewController()
            self.pushConfigurationViewController(viewController)
        }
        return [item]
    }

}
