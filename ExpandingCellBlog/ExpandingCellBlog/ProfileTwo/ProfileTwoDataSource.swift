//
//  BadProfileDataSource.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 01/12/2020.
//

import Foundation

class ProfileTwoDataSource {
    var data: [ProfileHeaderViewModel] = [ProfileHeaderViewModel(titleText: "Personal",
                                                                         cells: [.personal(PersonalCellViewModel(titleText: "Username:", descriptionText: "Kresimir")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Email:", descriptionText: "kresimir@gmail.com")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Password:", descriptionText: "*********")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Phone:", descriptionText: "+ 385 99 5656 561")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Address:", descriptionText: "Great Windmill Street 43"))],
                                                                         isExpanded: false),
                                              ProfileHeaderViewModel(titleText: "Payout Method",
                                                                         cells: [.payMethod(PayMethodCellViewModel(image: AppAssets.payPal.image))],
                                                                         isExpanded: false),
                                              ProfileHeaderViewModel(titleText: "Notifications",
                                                                         cells: [.notification(NotificationCellViewModel(titleText: "Email", isEnabled: false)),
                                                                                 .notification(NotificationCellViewModel(titleText: "Push notifications", isEnabled: true)),
                                                                                 .notification(NotificationCellViewModel(titleText: "Phone calls", isEnabled: false))],
                                                                         isExpanded: false)
    ]
    
    init() {}
}