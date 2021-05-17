//
//  Collection+.swift
//  Petersons
//
//  Created by Azzaro Mujic on 17/08/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
