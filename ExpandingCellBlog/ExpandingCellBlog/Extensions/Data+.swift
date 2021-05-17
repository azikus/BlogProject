//
//  Data+.swift
//  Petersons
//
//  Created by Azzaro Mujic on 07/08/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import Foundation

// Error
extension Data {
    func parseError() -> NSError {
        let data = self
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
              let dict = json as? [String: Any]
        else {
            return NSError(domain: "", code: 0, userInfo: nil)
        }
        let code = dict["Code"] as? Int ?? 0
        let message = dict["Message"] as? String ?? ""
        return NSError(domain: message, code: code, userInfo: nil)
    }
}
