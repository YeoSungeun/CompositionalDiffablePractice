//
//  MainTabBarController.swift
//  DiffableDataSourcePractice
//
//  Created by 여성은 on 7/19/24.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let setting = SettingViewController()
        let nav1 = UINavigationController(rootViewController: setting)
        nav1.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 0)
        
        let travelTalk = TravelTalViewContorller()
        let nav2 = UINavigationController(rootViewController: travelTalk)
        nav2.tabBarItem = UITabBarItem(title: "좋아요", image: UIImage(systemName: "bubble"), tag: 1)

        setViewControllers([nav1, nav2], animated: true)
    }

}
