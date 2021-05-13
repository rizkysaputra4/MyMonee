//
//  TabBarViewController.swift
//  MyMonee
//
//  Created by Rizky Saputra on 12/05/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.barTintColor = .white

        let home = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        let homeTab = UINavigationController(rootViewController: home)
        let homeImage = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        let homeImageSelected = UIImage(named: "home_active")?.withRenderingMode(.alwaysOriginal)
        homeTab.tabBarItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: homeImageSelected)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        homeTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        homeTab.tabBarItem.tag = 0

        let impian = DreamViewController(nibName: String(describing: DreamViewController.self), bundle: nil)
        let impianTab = UINavigationController(rootViewController: impian)
        let impianImage = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
        let impianImageSelected = UIImage(named: "heart_active")?.withRenderingMode(.alwaysOriginal)
        impianTab.tabBarItem = UITabBarItem(title: "Impian", image: impianImage, selectedImage: impianImageSelected)
  
        let profile = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: nil)
        let profileTab = UINavigationController(rootViewController: profile)
        let profileImage = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        let profileImageSelected = UIImage(named: "profile_active")?.withRenderingMode(.alwaysOriginal)
        profileTab.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, selectedImage: profileImageSelected)
        profileTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        profileTab.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        profileTab.tabBarItem.tag = 2
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "Selamat Sore, "
        profile.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        self.viewControllers = [homeTab, impianTab, profileTab]
    }

}
