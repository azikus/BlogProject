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
        
        let editProfileViewModel = EditProfileViewModel()
        let editProfileViewController = EditProfileViewController(viewModel: editProfileViewModel)
        
        let editProfileFixViewModel = EditProfileFixViewModel()
        let editProfileFixViewController = EditProfileFixViewController(viewModel: editProfileFixViewModel)
        
        let tabBarViewController = UITabBarController()
        tabBarViewController.tabBar.tintColor = .black
        tabBarViewController.tabBar.barTintColor = .gray247
        
        let editProfileNavigationController = UINavigationController(rootViewController: editProfileViewController)
        editProfileNavigationController.tabBarItem.title = "Edit profile"
        editProfileNavigationController.navigationBar.barTintColor = .gray247
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        editProfileNavigationController.navigationBar.titleTextAttributes = textAttributes
        
        let editProfileFixNavigationController = UINavigationController(rootViewController: editProfileFixViewController)
        editProfileFixNavigationController.tabBarItem.title = "Edit profile fix"
        editProfileFixNavigationController.navigationBar.barTintColor = .gray247
        editProfileFixNavigationController.navigationBar.titleTextAttributes = textAttributes

        tabBarViewController.viewControllers = [editProfileNavigationController, editProfileFixNavigationController]
        
        window?.rootViewController = tabBarViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
