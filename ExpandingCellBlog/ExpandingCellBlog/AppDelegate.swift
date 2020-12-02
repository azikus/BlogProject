//
//  AppDelegate.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 30/11/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: profileViewModel)
        profileViewController.tabBarItem.title = "ProfileVC"
        
        let badProfileViewModel = BadProfileViewModel()
        let badProfileViewController = BadProfileViewController(viewModel: badProfileViewModel)
        badProfileViewController.tabBarItem.title = "BadProfileVC"
        
        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [profileViewController, badProfileViewController]
        
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
