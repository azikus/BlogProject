//
//  EditProfileHeaderView.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 02/12/2020.
//

import UIKit
import RxSwift

protocol EditProfileHeaderViewDelegate {
    func toggleSection(for header: EditProfileHeaderView)
}

class EditProfileHeaderViewModel: Equatable {
    let titleText: String
    let items: [EditProfileCellType]
    var isExpanded: Bool
    
    init(titleText: String, cells: [EditProfileCellType], isExpanded: Bool) {
        self.titleText = titleText
        self.items = cells
        self.isExpanded = isExpanded
    }
    
    static func == (lhs: EditProfileHeaderViewModel, rhs: EditProfileHeaderViewModel) -> Bool {
        return lhs.titleText == rhs.titleText && lhs.items.count == rhs.items.count
    }
}

class EditProfileHeaderView: UITableViewHeaderFooterView {
    var delegate: EditProfileHeaderViewDelegate?
    var viewModel: EditProfileHeaderViewModel?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
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
        contentView.backgroundColor = .gray247
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
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(arrowImageView.snp.leading).offset(-20)
            $0.bottom.equalToSuperview().offset(-22)
        }
    }
    
    func update(viewModel: EditProfileHeaderViewModel) {
        titleLabel.text = viewModel.titleText
        self.viewModel = viewModel
    }
    
    @objc func handleTap() {
        delegate?.toggleSection(for: self)
        guard let viewModel = viewModel else { return }
        UIView.animate(withDuration: 0.3, animations: {
            self.arrowImageView.transform = viewModel.isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
        })
    }
}
