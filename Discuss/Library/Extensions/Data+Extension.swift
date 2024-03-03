//
//  Data+Extension.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 29.03.2023.
//

import Foundation

public extension Data {
    mutating func append(
        _ string: String,
        encoding: String.Encoding = .utf8
    ) {
        guard let data = string.data(using: encoding) else {
            return
        }
        append(data)
    }
}
