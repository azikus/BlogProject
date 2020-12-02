//
//  String+Localization.swift
//  Petersons
//
//  Created by Drago Ruzman on 03/08/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import Foundation

extension String {
    func localized(_ args: CVarArg...) -> String {
        guard !isEmpty else { return self }
        let localizedString = NSLocalizedString(self, comment: "")
        if args.isEmpty {
            return localizedString
        } else {
            return withVaList(args) { NSString(format: localizedString, locale: Locale.current, arguments: $0) as String }
        }
    }
}
