//
//  UIStackView+.swift
//  Petersons
//
//  Created by Azzaro Mujic on 01/09/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import SnapKit
import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { view in
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    func addSeparatorArrangedSubview(color: UIColor?, inset: Int = 0, height: CGFloat = 1) {
        let separatorView = UIView()
        separatorView.backgroundColor = color
        addArrangedSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(inset)
            make.height.equalTo(height)
        }
    }

    func addHorizontalSeparatorArrangedSubview(color: UIColor?, height: CGFloat = 0, width: CGFloat = 1) {
        let view = UIView()
        let separatorView = UIView()
        separatorView.backgroundColor = color

        view.addSubview(separatorView)
        separatorView.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(height)
            $0.width.equalTo(width)
        }

        addArrangedSubview(view)
    }
}
