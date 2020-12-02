//
//  Encodable+.swift
//  Petersons
//
//  Created by Azzaro Mujic on 17/08/2020.
//  Copyright © 2020 Speck. All rights reserved.
//

import Foundation

extension Encodable {
    var data: Data? {
        return try? JSONEncoder().encode(self)
    }

    var dictionaryOptional: [String: Any]? {
        guard let data = data else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
