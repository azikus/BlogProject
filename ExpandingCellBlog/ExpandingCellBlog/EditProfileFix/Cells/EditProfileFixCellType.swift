//
//  EditProfileFixCellType.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 04/12/2020.
//

import Foundation

enum EditProfileFixCellType {
    case header(EditProfileFixHeaderCellViewModel)
    case personal(PersonalCellViewModel)
    case payMethod(PayMethodCellViewModel)
    case notification(NotificationCellViewModel)
}
