//
//  BadProfileHeader.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 02/12/2020.
//

import UIKit
import RxSwift

protocol BadProfileHeaderDelegate {
    func toggleSection(header: BadProfileHeader)
}

class BadProfileHeaderViewModel: Equatable {
    let titleText: String
    let cells: [BadProfileCellType]
    var isExpanded: Bool
    
    init(titleText: String, cells: [BadProfileCellType], isExpanded: Bool) {
        self.titleText = titleText
        self.cells = cells
        self.isExpanded = isExpanded
    }
    
    static func == (lhs: BadProfileHeaderViewModel, rhs: BadProfileHeaderViewModel) -> Bool {
        return lhs.titleText == rhs.titleText && lhs.cells.count == rhs.cells.count
    }
}

class BadProfileHeader: UITableViewHeaderFooterView {
    var delegate: BadProfileHeaderDelegate?
    var viewModel: BadProfileHeaderViewModel?
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppAssets.downArrow.image
        
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
        backgroundColor = .white
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        addSubviews()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(arrowImageView)
    }
    
    private func setConstraints() {
        arrowImageView.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(10)
            $0.width.equalTo(17)
        }
    }
    
    func update(viewModel: BadProfileHeaderViewModel) {
        self.textLabel?.text = viewModel.titleText
        self.viewModel = viewModel
        UIView.animate(withDuration: 0.3, animations: {
            self.arrowImageView.transform = viewModel.isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
        })
    }
    
    @objc func handleTap() {
        delegate?.toggleSection(header: self)
    }
}
