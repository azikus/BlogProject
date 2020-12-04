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
        
        let profileOneViewModel = ProfileOneViewModel()
        let profileOneViewController = ProfileOneViewController(viewModel: profileOneViewModel)
        
        let profileTwoViewModel = ProfileTwoViewModel()
        let profileTwoViewController = ProfileTwoViewController(viewModel: profileTwoViewModel)
        
        let tabBarViewController = UITabBarController()
        tabBarViewController.tabBar.tintColor = .black
        tabBarViewController.tabBar.barTintColor = .gray247
        
        let profileOneNavigationController = UINavigationController(rootViewController: profileOneViewController)
        profileOneNavigationController.tabBarItem.title = "Edit profile 1"
        profileOneNavigationController.navigationBar.barTintColor = .gray247
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        profileOneNavigationController.navigationBar.titleTextAttributes = textAttributes
        let profileTwoNavigationController = UINavigationController(rootViewController: profileTwoViewController)
        profileTwoNavigationController.tabBarItem.title = "Edit profile 2"
        profileTwoNavigationController.navigationBar.barTintColor = .gray247
        profileTwoNavigationController.navigationBar.titleTextAttributes = textAttributes

        tabBarViewController.viewControllers = [profileOneNavigationController, profileTwoNavigationController]
        
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
