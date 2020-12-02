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
        
        let profileViewModel = ProfileOneViewModel()
        let profileViewController = ProfileOneViewController(viewModel: profileViewModel)
        profileViewController.tabBarItem.title = "Profile 1"
        
        let badProfileViewModel = ProfileTwoViewModel()
        let badProfileViewController = ProfileTwoViewController(viewModel: badProfileViewModel)
        badProfileViewController.tabBarItem.title = "Profile 2 "
        
        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [profileViewController, badProfileViewController]
        
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
