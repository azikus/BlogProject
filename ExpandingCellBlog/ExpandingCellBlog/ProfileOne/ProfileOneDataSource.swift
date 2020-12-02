//
//  ProfileDataSource.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 01/12/2020.
//

import Foundation

class ProfileOneDataSource {
    var data: [ProfileOneCellType] = [.header(ProfileHeaderCellViewModel(titleText: "Personal",
                                                                         cells: [.personal(PersonalCellViewModel(titleText: "Username:", descriptionText: "Kresimir")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Email:", descriptionText: "kresimir@gmail.com")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Password:", descriptionText: "*********")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Phone:", descriptionText: "+ 385 99 5656 561")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Address:", descriptionText: "Great Windmill Street 43")),
                                                                                 .personal(PersonalCellViewModel(titleText: "City:", descriptionText: "Zagreb")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Conutry:", descriptionText: "Croatia")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Gender:", descriptionText: "Male")),
                                                                                 .personal(PersonalCellViewModel(titleText: "Nickname:", descriptionText: "Soksijada"))],
                                                                         isExpanded: false)),
                                      .header(ProfileHeaderCellViewModel(titleText: "Payout Method",
                                                                         cells: [.payMethod(PayMethodCellViewModel(image: AppAssets.aircash.image)),
                                                                                 .payMethod(PayMethodCellViewModel(image: AppAssets.applePay.image)),
                                                                                 .payMethod(PayMethodCellViewModel(image: AppAssets.googlePay.image)),
                                                                                 .payMethod(PayMethodCellViewModel(image: AppAssets.payPal.image)),
                                                                                 .payMethod(PayMethodCellViewModel(image: AppAssets.maestro.image)),
                                                                                 .payMethod(PayMethodCellViewModel(image: AppAssets.visa.image)),
                                                                                 .payMethod(PayMethodCellViewModel(image: AppAssets.bitcoin.image)),
                                                                                 .payMethod(PayMethodCellViewModel(image: AppAssets.masterCard.image))],
                                                                         isExpanded: false)),
                                      .header(ProfileHeaderCellViewModel(titleText: "Notifications",
                                                                         cells: [.notification(NotificationCellViewModel(titleText: "Email", isEnabled: false)),
                                                                                 .notification(NotificationCellViewModel(titleText: "Push notifications", isEnabled: true)),
                                                                                 .notification(NotificationCellViewModel(titleText: "Phone calls", isEnabled: false)),
                                                                                 .notification(NotificationCellViewModel(titleText: "Facebook", isEnabled: false)),
                                                                                 .notification(NotificationCellViewModel(titleText: "Twitter", isEnabled: false)),
                                                                                 .notification(NotificationCellViewModel(titleText: "Instagram", isEnabled: false)),
                                                                                 .notification(NotificationCellViewModel(titleText: "TikTok", isEnabled: true)),
                                                                                 .notification(NotificationCellViewModel(titleText: "LinkedIn", isEnabled: false))],
                                                                         isExpanded: false))
    ]
    
    var flattenDataSource: [ProfileOneCellType] = []
    
    init() {
        flatDataSource()
    }
    
    func findChildIndexPathsOfHeader(with indexPath: IndexPath) -> [IndexPath] {
        var childIndexPaths: [IndexPath] = []
        let selectedCell = flattenDataSource[indexPath.row]
        switch selectedCell {
        case .header(let selectedCellViewModel):
            for headerCell in data {
                switch headerCell {
                case .header(let dataSourceViewModel):
                    if selectedCellViewModel == dataSourceViewModel {
                        let numberOfChildren = dataSourceViewModel.cells.count
                        for i in 1...numberOfChildren {
                            let indexPath = IndexPath(item: indexPath.row + i, section: 0)
                            childIndexPaths.append(indexPath)
                        }
                    }
                default:
                    break
                }
            }
        default:
            break
        }
        return childIndexPaths
    }
    
    func flatDataSource() {
        var flattenArray: [ProfileOneCellType] = []
        for cell in data {
            flattenArray.append(cell)
            var childCells: [ProfileOneCellType] = []
            switch cell {
            case .header(let viewModel):
                if viewModel.isExpanded {
                    childCells.append(contentsOf: viewModel.cells)
                }
            default:
                break
            }
            flattenArray.append(contentsOf: childCells)
        }
        flattenDataSource = flattenArray
    }
}
