//
//  TableViewHeader.swift
//  ExpandingCellBlog
//
//  Created by Krešimir Baković on 04/12/2020.
//

import UIKit

class TableViewHeader: UIView {
    
    // MARK: - Views
    lazy var circleView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 50
        
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppAssets.user.image
        
        return imageView
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Picture", for: .normal)
        button.setTitleColor(.gray161, for: .normal)
        
        return button
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180))
        addSubviews()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func addSubviews() {
        addSubview(circleView)
        circleView.addSubview(profileImageView)
        addSubview(editButton)
    }
    
    private func setConstraints() {
        circleView.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        profileImageView.snp.remakeConstraints {
            $0.center.equalTo(circleView)
            $0.height.width.equalTo(65)
        }
        
        editButton.snp.remakeConstraints {
            $0.top.equalTo(circleView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
    }
}
