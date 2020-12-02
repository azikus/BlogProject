//
//  Date+.swift
//  Petersons
//
//  Created by Azzaro Mujic on 01/09/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import UIKit

extension Date {
    func toDefaultString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: self)
    }
}
