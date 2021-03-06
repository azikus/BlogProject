//
//  EditProfileCellType.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 01/12/2020.
//

import Foundation

enum EditProfileCellType {
    case personal(PersonalCellViewModel)
    case payMethod(PayMethodCellViewModel)
    case notification(NotificationCellViewModel)
}
