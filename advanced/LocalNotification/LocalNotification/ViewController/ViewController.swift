//
//  ViewController.swift
//  LocalNotification
//
//  Created by SHIN YOON AH on 2021/11/25.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let userNotificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestNotificationAuthorization()
        sendNotification(seconds: 10)
    }

    /// 사용자에게 알림 권한을 요청
    /// 사용자에게 알림 권한에 대한 허용 여부를 묻는 팝업 생성
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }

    /// 알림을 보낼 함수
    func sendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "알림 테스트"
        notificationContent.body = "이것은 알림을 테스트 하는 것이다."
        
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
}
