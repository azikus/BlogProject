//
//  AppAssets.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 30/11/2020.
//

import UIKit

enum AppAssets: String {
    case downArrow
    case payPal
    case circleDeselected
    case circleSelected
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }
}
