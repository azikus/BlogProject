//
//  ProfileCell.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 30/11/2020.
//

import UIKit

class PersonalCellViewModel {
    let titleText: String
    let descriptionText: String
    
    init(titleText: String, descriptionText: String) {
        self.titleText = titleText
        self.descriptionText = descriptionText
    }
}

class PersonalCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()

    lazy var changeButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Change", for: .normal)
        button.tintColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 2
        
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
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
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(changeButton)
    }

    func setConstraints() {
        changeButton.snp.remakeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.bottom.equalToSuperview().inset(15)
            $0.height.equalTo(30)
            $0.width.equalTo(70)
        }
        
        titleLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(25)
        }
        
        descriptionLabel.snp.remakeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(3)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(changeButton.snp.leading).offset(-10)
        }
    }

    func update(viewModel: PersonalCellViewModel) {
        titleLabel.text = viewModel.titleText
        descriptionLabel.text = viewModel.descriptionText
    }
}
