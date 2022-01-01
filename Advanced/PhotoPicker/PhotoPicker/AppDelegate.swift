//
//  AppDelegate.swift
//  PhotoPicker
//
//  Created by SHIN YOON AH on 2021/06/19.
//

import UIKit
import Photos

var allPhotos: PHFetchResult<PHAsset>? = nil
var photocount = Int()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to preceed")
                let fetchOptions = PHFetchOptions()
                allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                photocount = allPhotos?.count ?? 0
            case .notDetermined:
                print("Not allowed")
            case .restricted, .denied:
                print("Not determined yet")
            @unknown default:
                print("error")
            }
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

