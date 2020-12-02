//
//  UIView+.swift
//  Petersons
//
//  Created by Azzaro Mujic on 04/08/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import UIKit

protocol Identifiable {
    static var identity: String { get }
}

extension UIView: Identifiable {
    static var identity: String {
        return String(describing: self)
    }
}
