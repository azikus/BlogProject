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

class ProfileOneViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: ProfileOneViewModel
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
        tableView.register(ProfileHeaderCell.self, forCellReuseIdentifier: ProfileHeaderCell.identity)
        tableView.register(PersonalCell.self, forCellReuseIdentifier: PersonalCell.identity)
        tableView.register(PayMethodCell.self, forCellReuseIdentifier: PayMethodCell.identity)
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.identity)
        tableView.tableHeaderView = TableViewHeader()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    lazy var searchBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: AppAssets.search.image, style: .plain, target: self, action: nil)
        item.tintColor = .black
        
        return item
    }()
    
    lazy var cameraBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: AppAssets.camera.image, style: .plain, target: self, action: nil)
        item.tintColor = .black
        
        return item
    }()
    
    lazy var dotsBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: AppAssets.dots.image, style: .plain, target: self, action: nil)
        item.tintColor = .black
        
        return item
    }()
    
    lazy var hearthBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: AppAssets.hearth.image, style: .plain, target: self, action: nil)
        item.tintColor = .black
        
        return item
    }()
    
    var dataSource = ProfileOneDataSource()
    
    init(viewModel: ProfileOneViewModel) {
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
        title = "Edit profile 1"
        view.backgroundColor = .white
        setNavigationBar()
        addSubviews()
        setConstraints()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItems = [searchBarButton, cameraBarButton]
        navigationItem.rightBarButtonItems = [dotsBarButton, hearthBarButton]
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.remakeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func hideChildCellsForHeader(with indexPath: IndexPath) {
        let childrenIndexPaths = dataSource.findChildIndexPathsOfHeader(with: indexPath)
        tableView.deleteRows(at: childrenIndexPaths, with: .fade)
    }
    
    private func showChildCellsForHeader(with indexPath: IndexPath) {
        let childrenIndexPaths = dataSource.findChildIndexPathsOfHeader(with: indexPath)
        tableView.insertRows(at: childrenIndexPaths, with: .fade)
    }
}

// MARK: - UITableViewDelegate

extension ProfileOneViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataSource.flattenDataSource[indexPath.row] {
        case .header(let viewModel):
            if viewModel.isExpanded {
                viewModel.isExpanded = false
                dataSource.flatDataSource()
                hideChildCellsForHeader(with: indexPath)
            } else {
                viewModel.isExpanded = true
                dataSource.flatDataSource()
                showChildCellsForHeader(with: indexPath)
            }
            let clickedCell = tableView.cellForRow(at: indexPath) as? ProfileHeaderCell
            clickedCell?.update(viewModel: viewModel, animated: true)
        case .notification(let viewModel):
            let clickedCell = tableView.cellForRow(at: indexPath) as? NotificationCell
            viewModel.isEnabled.toggle()
            clickedCell?.update(viewModel: viewModel)
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource

extension ProfileOneViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.flattenDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource.flattenDataSource[indexPath.row] {
        case .header(let viewModel):
            let cell: ProfileHeaderCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
            cell.update(viewModel: viewModel, animated: false)
            return cell
        case .notification(let viewModel):
            let cell: NotificationCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
            cell.update(viewModel: viewModel)
            return cell
        case .payMethod(let viewModel):
            let cell: PayMethodCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
            cell.update(viewModel: viewModel)
            return cell
        case .personal(let viewModel):
            let cell: PersonalCell = tableView.dequeueCellAtIndexPath(indexPath: indexPath)
            cell.update(viewModel: viewModel)
            return cell
        }
    }
}
