//
//  PayMethodCell.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 30/11/2020.
//

import UIKit

struct PayMethodCellViewModel {
    let image: UIImage?
}

class PayMethodCell: UITableViewCell {
    
    lazy var methodImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var addMethodButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Add method", for: .normal)
        button.tintColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 2
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        backgroundColor = .white
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        contentView.addSubview(methodImageView)
        contentView.addSubview(addMethodButton)
    }

    func setConstraints() {
        methodImageView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().offset(25)
            $0.height.equalTo(25)
            $0.width.equalTo(60)
        }
        
        addMethodButton.snp.remakeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40)
        }
    }

    func update(viewModel: PayMethodCellViewModel) {
        methodImageView.image = viewModel.image
    }
}
