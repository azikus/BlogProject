//
//  EditProfileViewController.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 01/12/2020.
//

import UIKit
import RxSwift

class EditProfileViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: EditProfileViewModel
    
    // MARK: - Views
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
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
    
    var dataSource = EditProfileDataSource()
    
    init(viewModel: EditProfileViewModel) {
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
        title = "Edit profile"
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
    
    private func indexOfHeader(header: EditProfileHeaderViewModel) -> Int {
        for (index, dataSourceHeader) in dataSource.data.enumerated() {
            if header == dataSourceHeader {
                return index
            }
        }
        return 0
    }
    
    private func hideChildCellsForHeader(with index: Int) {
        let childrenIndexPaths = dataSource.findChildIndexPathsOfHeader(with: index)
        tableView.deleteRows(at: childrenIndexPaths, with: .fade)
    }
    
    private func showChildCellsForHeader(with index: Int) {
        let childrenIndexPaths = dataSource.findChildIndexPathsOfHeader(with: index)
        tableView.insertRows(at: childrenIndexPaths, with: .fade)
    }
}

// MARK: - UITableViewDelegate

extension EditProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dataSource.data[indexPath.section].cells[indexPath.row] {
        case.notification(let viewModel):
            let clickedCell = tableView.cellForRow(at: indexPath) as? NotificationCell
            viewModel.isEnabled.toggle()
            clickedCell?.update(viewModel: viewModel)
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource

extension EditProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.data[section].isExpanded {
            return dataSource.data[section].cells.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = EditProfileHeaderView()
        header.delegate = self
        header.update(viewModel: dataSource.data[section])
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource.data[indexPath.section].cells[indexPath.row] {
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

// MARK: - ProfileHeaderViewDelegate

extension EditProfileViewController: EditProfileHeaderViewDelegate {
    func toggleSection(for header: EditProfileHeaderView) {
        guard let viewModel = header.viewModel else { return }
        let headerIndex = indexOfHeader(header: viewModel)
        if viewModel.isExpanded {
            viewModel.isExpanded = false
            hideChildCellsForHeader(with: headerIndex)
        } else {
            viewModel.isExpanded = true
            showChildCellsForHeader(with: headerIndex)
        }
    }
}
