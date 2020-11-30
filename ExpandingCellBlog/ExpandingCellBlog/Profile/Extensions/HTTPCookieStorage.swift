//
//  HTTPCookieStorage.swift
//  Petersons
//
//  Created by Azzaro Mujic on 30/09/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import Foundation

extension HTTPCookieStorage {
    func clearAllCookies() {
        HTTPCookieStorage.shared.cookies?.forEach { cookie in
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }
}
