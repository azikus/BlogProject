//
//  String+.swift
//  Petersons
//
//  Created by Dino Bozic on 24/08/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import CoreGraphics
import UIKit

extension String {
    func toURL() -> URL? {
        URL(string: self)
    }
}

extension UIColor {
    func toHex() -> String {
        let numberOfColorComponents: Int = cgColor.numberOfComponents
        let colorComponents = cgColor.components!

        var colorHexString = ""
        if numberOfColorComponents == 4 {
            let red = colorComponents[0] * 255
            let green = colorComponents[1] * 255
            let blue = colorComponents[2] * 255

            colorHexString = NSString(format: "%02X%02X%02X", Int(red), Int(green), Int(blue)) as String
        } else if numberOfColorComponents == 2 {
            let white = colorComponents[0] * 255

            colorHexString = NSString(format: "%02X%02X%02X", Int(white), Int(white), Int(white)) as String
        } else {
            return "Color format noch supported"
        }

        return colorHexString
    }
}

extension String {
    func htmlFormattedString(font: UIFont, color: UIColor) -> String {
        return NSString(format: "<html>\n <head>\n <style type=\"text/css\">\n body {font-family: \"%@\"; font-size: %@; color:#%@;}\n </style>\n </head>\n <body>%@</body>\n </html>", font.familyName, "\(font.pointSize)", color.toHex(), self) as String
    }

    func toInt() -> Int? {
        return Int(self)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
}
