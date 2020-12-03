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
                                                                         .personal(PersonalCellViewModel(titleText: "Address:", descriptionText: "Great Windmill Street 43")),
                                                                         .personal(PersonalCellViewModel(titleText: "City:", descriptionText: "Zagreb")),
                                                                         .personal(PersonalCellViewModel(titleText: "Conutry:", descriptionText: "Croatia")),
                                                                         .personal(PersonalCellViewModel(titleText: "Gender:", descriptionText: "Male")),
                                                                         .personal(PersonalCellViewModel(titleText: "Nickname:", descriptionText: "Soksijada"))],
                                                                 isExpanded: false),
                                          ProfileHeaderViewModel(titleText: "Payout Method",
                                                                 cells: [.payMethod(PayMethodCellViewModel(image: AppAssets.aircash.image)),
                                                                         .payMethod(PayMethodCellViewModel(image: AppAssets.applePay.image)),
                                                                         .payMethod(PayMethodCellViewModel(image: AppAssets.googlePay.image)),
                                                                         .payMethod(PayMethodCellViewModel(image: AppAssets.payPal.image)),
                                                                         .payMethod(PayMethodCellViewModel(image: AppAssets.maestro.image)),
                                                                         .payMethod(PayMethodCellViewModel(image: AppAssets.visa.image)),
                                                                         .payMethod(PayMethodCellViewModel(image: AppAssets.bitcoin.image)),
                                                                         .payMethod(PayMethodCellViewModel(image: AppAssets.masterCard.image))],
                                                                 isExpanded: false),
                                          ProfileHeaderViewModel(titleText: "Notifications",
                                                                 cells: [.notification(NotificationCellViewModel(titleText: "Email", isEnabled: false)),
                                                                         .notification(NotificationCellViewModel(titleText: "Push notifications", isEnabled: true)),
                                                                         .notification(NotificationCellViewModel(titleText: "Phone calls", isEnabled: false)),
                                                                         .notification(NotificationCellViewModel(titleText: "Facebook", isEnabled: false)),
                                                                         .notification(NotificationCellViewModel(titleText: "Twitter", isEnabled: false)),
                                                                         .notification(NotificationCellViewModel(titleText: "Instagram", isEnabled: false)),
                                                                         .notification(NotificationCellViewModel(titleText: "TikTok", isEnabled: true)),
                                                                         .notification(NotificationCellViewModel(titleText: "LinkedIn", isEnabled: false))],
                                                                 isExpanded: false)
    ]
    
    init() {}
    
    func findChildIndexPathsOfHeader(with headerIndex: Int) -> [IndexPath] {
        var childrenIndexPaths: [IndexPath] = []
        let numberOfChildern = data[headerIndex].cells.count
        for index in 0..<numberOfChildern {
            childrenIndexPaths.append(IndexPath(item: index, section: headerIndex))
        }
        return childrenIndexPaths
    }
}
