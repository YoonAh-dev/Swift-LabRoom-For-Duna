//
//  CustomTabbarController.swift
//  CustomTabbarController+Example
//
//  Created by SHIN YOON AH on 2021/11/18.
//

import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
    }
}

class CustomTabbarController: UITabBarController {
    let writeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 56, height: 56))

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupTabbar()
        setupWriteButton()
    }
    
    private func configUI() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.white
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
    }
    
    private func setupTabbar() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let homeTab = storyboard.instantiateViewController(identifier: "ViewController")
        homeTab.tabBarItem = UITabBarItem(title: "메인", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let circleTab = storyboard.instantiateViewController(identifier: "ViewController")
        circleTab.tabBarItem = UITabBarItem(title: "동그라미", image: UIImage(systemName: "circle"), selectedImage: UIImage(systemName: "circle.fill"))
        
        let tab = UIViewController()
        tab.tabBarItem = UITabBarItem()
        
        let friendTab = storyboard.instantiateViewController(identifier: "ViewController")
        friendTab.tabBarItem = UITabBarItem(title: "친구", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let mypageTab = storyboard.instantiateViewController(identifier: "ViewController")
        mypageTab.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "circle"), selectedImage: UIImage(systemName: "circle.fill"))
        
        let tabs =  [homeTab, circleTab, tab, friendTab, mypageTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = homeTab
    }

    private func setupWriteButton() {
        var writeTabFrame = writeButton.frame
        writeTabFrame.origin.y = self.tabBar.frame.minY - writeButton.frame.height / 1.2
        writeTabFrame.origin.x = view.bounds.width / 2 - writeTabFrame.size.width / 2
        writeButton.frame = writeTabFrame
        
        writeButton.backgroundColor = UIColor.systemRed
        writeButton.layer.cornerRadius = writeTabFrame.height / 2
        view.addSubview(writeButton)
        
        writeButton.setImage(UIImage(systemName: "moon"), for: .normal)
    }
}
