//
//  ProfileSectionCell.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 30/11/2020.
//

import UIKit

enum ProfileOneCellType {
    case header(ProfileHeaderCellViewModel)
    case personal(PersonalCellViewModel)
    case payMethod(PayMethodCellViewModel)
    case notification(NotificationCellViewModel)
}

class ProfileHeaderCellViewModel: Equatable {
    let titleText: String
    let cells: [ProfileOneCellType]
    var isExpanded: Bool
    
    init(titleText: String, cells: [ProfileOneCellType], isExpanded: Bool) {
        self.titleText = titleText
        self.cells = cells
        self.isExpanded = isExpanded
    }
    
    static func == (lhs: ProfileHeaderCellViewModel, rhs: ProfileHeaderCellViewModel) -> Bool {
        return lhs.titleText == rhs.titleText && lhs.cells.count == rhs.cells.count
    }
}

class ProfileHeaderCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppAssets.downArrow.image
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .gray247
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
    }
    
    func setConstraints() {
        arrowImageView.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(10)
            $0.width.equalTo(17)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-20)
            $0.bottom.equalToSuperview().offset(-22)
        }
    }
    
    func update(viewModel: ProfileHeaderCellViewModel, animated: Bool) {
        titleLabel.text = viewModel.titleText
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.arrowImageView.transform = viewModel.isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
            })
        }
    }
}
