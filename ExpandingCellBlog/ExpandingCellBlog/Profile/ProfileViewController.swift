//
//  ProfileViewController.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 30/11/2020.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class ProfileViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: ProfileViewModel
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
        tableView.register(ProfileSectionCell.self, forCellReuseIdentifier: ProfileSectionCell.identity)
        tableView.register(PersonalCell.self, forCellReuseIdentifier: PersonalCell.identity)
        tableView.register(PayMethodCell.self, forCellReuseIdentifier: PayMethodCell.identity)
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.identity)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    var dataSource = [ProfileSectionCellViewModel(titleText: "Personal",
                                                  cells: [.personal(PersonalCellViewModel(titleText: "Username:", descriptionText: "Kresimir")),
                                                          .personal(PersonalCellViewModel(titleText: "Email:", descriptionText: "kresimir@gmail.com")),
                                                          .personal(PersonalCellViewModel(titleText: "Password:", descriptionText: "*********")),
                                                          .personal(PersonalCellViewModel(titleText: "Phone:", descriptionText: "+ 385 99 5656 561")),
                                                          .personal(PersonalCellViewModel(titleText: "Address:", descriptionText: "Great Windmill Street 43"))],
                                                  isExpanded: false),
                      ProfileSectionCellViewModel(titleText: "Payout Method",
                                                  cells: [.payMethod(PayMethodCellViewModel(image: AppAssets.payPal.image))],
                                                  isExpanded: false),
                      ProfileSectionCellViewModel(titleText: "Notifications",
                                                  cells: [.notification(NotificationCellViewModel(titleText: "Email", isEnabled: false)),
                                                          .notification(NotificationCellViewModel(titleText: "Push notifications", isEnabled: true)),
                                                          .notification(NotificationCellViewModel(titleText: "Phone calls", isEnabled: false))],
                                                  isExpanded: false)
    ]
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraints()
        observe()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        
    }
    
    private func setConstraints() {
        tableView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func observe() {
        
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource[section].isExpanded {
            return dataSource[section].cells.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: ProfileSectionCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
            cell.update(viewModel: dataSource[indexPath.section])
            return cell
        } else {
            switch dataSource[indexPath.section].cells[indexPath.row - 1] {
            case .personal(let viewModel):
                let cell: PersonalCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
                cell.update(viewModel: viewModel)
                return cell
            case .payMethod(let viewModel):
                let cell: PayMethodCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
                cell.update(viewModel: viewModel)
                return cell
            case .notification(let viewModel):
                let cell: NotificationCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
                cell.update(viewModel: viewModel)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if dataSource[indexPath.section].isExpanded {
                dataSource[indexPath.section].isExpanded = false
                let sections = IndexSet(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                dataSource[indexPath.section].isExpanded = true
                let sections = IndexSet(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
            let clickedCell = tableView.cellForRow(at: indexPath) as? ProfileSectionCell
            clickedCell?.rotateArrowImage()
        } else {
            switch dataSource[indexPath.section].cells[indexPath.row - 1] {
            case .notification(_):
                let clickedCell = tableView.cellForRow(at: indexPath) as? NotificationCell
                clickedCell?.toggleSelection()
            default:
                print("Default")
            }
        }
    }
}
