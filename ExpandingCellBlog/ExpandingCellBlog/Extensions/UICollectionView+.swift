//
//  UICollectionView+.swift
//  Petersons
//
//  Created by Azzaro Mujic on 04/08/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueCellAtIndexPath<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: T.identity, for: indexPath) as? T {
            return cell
        } else {
            fatalError("cell with \"\(T.identity)\" identifier is not registered!")
        }
    }
}
