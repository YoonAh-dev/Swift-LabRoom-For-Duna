//
//  ContentViewController.swift
//  Share
//
//  Created by SHIN YOON AH on 2022/01/01.
//

import UIKit
import Social
import MobileCoreServices
import PhotosUI
import UserNotifications

final class ContentViewController: UIViewController {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLAbel: UILabel!
    @IBOutlet weak var imageButton: UIButton!
    
    private let userNotificationCenter = UNUserNotificationCenter.current()
    private var notificationServices = 1
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestNotificationAuthorization()
        configUI()
        setupExtensionItems()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        imageview.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        imageview.layer.cornerRadius = 50
    }
    
    
    private func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    private func setupExtensionItems() {
        let extensionItems = extensionContext?.inputItems as! [NSExtensionItem]
        for extensionItem in extensionItems {
            if let itemProviders = extensionItem.attributedContentText {
                titleLabel.text = itemProviders.string
            }
            
            if let itemProviders = extensionItem.attachments {
                for itemProvider in itemProviders {
                    if itemProvider.hasItemConformingToTypeIdentifier(UTType.url.identifier as String) {
                        itemProvider.loadItem(forTypeIdentifier: UTType.url.identifier as String, options: nil, completionHandler: { result, error in
                            DispatchQueue.main.async {
                                if let urlStr = result {
                                    self.urlLAbel.text = "\(urlStr)"
                                }
                            }
                        })
                        
                        if let userDefaults = UserDefaults(suiteName: "group.com.tiekle.Action-Extension-Shared.Share") {
                            let inapp = userDefaults.bool(forKey: "inapp")
                            
                            if !inapp {
                                itemProvider.loadPreviewImage(options: nil) {
                                    result, error in
                                    var image: UIImage?
                                    
                                    DispatchQueue.main.async {
                                        self.imageButton.isHidden = true
                                        if result is UIImage {
                                            image = result as? UIImage
                                            self.imageview.image = image
                                        }
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    private func sendNotification(seconds: Double, category: String) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = category
        notificationContent.body = "콘텐츠 저장이 완료되었습니다."
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "test",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
        
    @IBAction func touchUpButton(_ sender: Any) {
        if let userDefaults = UserDefaults(suiteName: "group.com.tiekle.Action-Extension-Shared.Share") {
            if let text = titleLabel.text {
                userDefaults.set(text, forKey: "text")
            }
            
            if let memo = urlLAbel.text {
                userDefaults.set(memo, forKey: "memo")
            }
            
            if let image = imageview.image {
                let jpgImage = image.jpegData(compressionQuality: 0.5)        // 10분의 1로 축소
                userDefaults.set(jpgImage, forKey: "image")
            }
            
            userDefaults.set(category, forKey: "category")
            
            userDefaults.set(false, forKey: "inapp")
        }
        
        self.hideExtensionWithCompletionHandler(completion: { _ in
            self.sendNotification(seconds: 1, category: self.category ?? "잘못된 저장")
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
        })
    }
    
    @IBAction func touchUpImage(_ sender: Any) {
        var photoConfiguration = PHPickerConfiguration()
        photoConfiguration.filter = .images
        photoConfiguration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: photoConfiguration)
        
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func hideExtensionWithCompletionHandler(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.view.transform = CGAffineTransform(translationX: 0,    y:self.navigationController!.view.frame.size.height)
        }, completion: completion)
    }
}

extension ContentViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.imageview.image = image as? UIImage
                    self.imageButton.isHidden = true
                }
            }
        }
    }
}
