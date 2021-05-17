//
//  UINavigationController+.swift
//  Petersons
//
//  Created by Azzaro Mujic on 08/09/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import UIKit

import UIKit

extension UINavigationController {
    func replaceTopViewController(with viewController: UIViewController, animated: Bool = true) {
        var viewControllers = Array(self.viewControllers.dropLast())
        viewControllers.append(viewController)
        setViewControllers(viewControllers, animated: animated)
    }

    func replaceTopViewControllers(count: Int, with viewController: UIViewController, animated: Bool = true) {
        var viewControllers = Array(self.viewControllers.dropLast(count))
        viewControllers.append(viewController)
        setViewControllers(viewControllers, animated: animated)
    }

    func popViewControllers(count: Int, animated: Bool = true) {
        setViewControllers(Array(viewControllers.dropLast(count)), animated: animated)
    }

    func pushOnRoot(viewController: UIViewController, animated: Bool = true) {
        var viewControllers: [UIViewController] = []
        if let rootVc = self.viewControllers.first {
            viewControllers.append(rootVc)
        }
        viewControllers.append(viewController)
        setViewControllers(viewControllers, animated: animated)
    }
    
    func pushViewControllers(with viewControllers: [UIViewController], animated: Bool = true) {
        var newViewControllerss = Array(self.viewControllers)
        newViewControllerss.append(contentsOf: viewControllers)
        setViewControllers(newViewControllerss, animated: animated)
    }

    func updateNavigationBar(isTranslucent: Bool) {
        if isTranslucent {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.isTranslucent = true
        } else {
            navigationBar.isTranslucent = false
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
        }
    }
}
