//
//  BadProfileCellType.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 01/12/2020.
//

import Foundation

enum BadProfileCellType {
    case personal(PersonalCellViewModel)
    case payMethod(PayMethodCellViewModel)
    case notification(NotificationCellViewModel)
}
