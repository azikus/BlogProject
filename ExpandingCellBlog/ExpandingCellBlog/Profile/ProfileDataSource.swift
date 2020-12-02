//
//  ProfileDataSource.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 01/12/2020.
//

import Foundation

class ProfileDataSource {
    var data: [ProfileCellType] = [.header(ProfileHeaderCellViewModel(titleText: "Personal",
                                                                     cells: [.personal(PersonalCellViewModel(titleText: "Username:", descriptionText: "Kresimir")),
                                                                             .personal(PersonalCellViewModel(titleText: "Email:", descriptionText: "kresimir@gmail.com")),
                                                                             .personal(PersonalCellViewModel(titleText: "Password:", descriptionText: "*********")),
                                                                             .personal(PersonalCellViewModel(titleText: "Phone:", descriptionText: "+ 385 99 5656 561")),
                                                                             .personal(PersonalCellViewModel(titleText: "Address:", descriptionText: "Great Windmill Street 43"))],
                                                                     isExpanded: false)),
                                  .header(ProfileHeaderCellViewModel(titleText: "Payout Method",
                                                                     cells: [.payMethod(PayMethodCellViewModel(image: AppAssets.payPal.image))],
                                                                     isExpanded: false)),
                                  .header(ProfileHeaderCellViewModel(titleText: "Notifications",
                                                                     cells: [.notification(NotificationCellViewModel(titleText: "Email", isEnabled: false)),
                                                                             .notification(NotificationCellViewModel(titleText: "Push notifications", isEnabled: true)),
                                                                             .notification(NotificationCellViewModel(titleText: "Phone calls", isEnabled: false))],
                                                                     isExpanded: false))
    ]
    
    var flattenDataSource: [ProfileCellType] = []
    
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
        var flattenArray: [ProfileCellType] = []
        for cell in data {
            flattenArray.append(cell)
            var childCells: [ProfileCellType] = []
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
