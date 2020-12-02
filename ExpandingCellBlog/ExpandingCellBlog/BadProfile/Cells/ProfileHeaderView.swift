//
//  BadProfileHeader.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 02/12/2020.
//

import UIKit
import RxSwift

protocol ProfileHeaderViewDelegate {
    func toggleSection(header: ProfileHeaderView)
}

class ProfileHeaderViewModel: Equatable {
    let titleText: String
    let cells: [ProfileTwoCellType]
    var isExpanded: Bool
    
    init(titleText: String, cells: [ProfileTwoCellType], isExpanded: Bool) {
        self.titleText = titleText
        self.cells = cells
        self.isExpanded = isExpanded
    }
    
    static func == (lhs: ProfileHeaderViewModel, rhs: ProfileHeaderViewModel) -> Bool {
        return lhs.titleText == rhs.titleText && lhs.cells.count == rhs.cells.count
    }
}

class ProfileHeaderView: UITableViewHeaderFooterView {
    var delegate: ProfileHeaderViewDelegate?
    var viewModel: ProfileHeaderViewModel?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppAssets.downArrow.image
        
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
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
        self.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        arrowImageView.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(10)
            $0.width.equalTo(17)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-20)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func update(viewModel: ProfileHeaderViewModel) {
        titleLabel.text = viewModel.titleText
        self.viewModel = viewModel
        UIView.animate(withDuration: 0.3, animations: {
            self.arrowImageView.transform = viewModel.isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
        })
    }
    
    @objc func handleTap() {
        delegate?.toggleSection(header: self)
    }
}
