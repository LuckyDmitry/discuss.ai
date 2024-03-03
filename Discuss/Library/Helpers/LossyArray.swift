//
//  LossyArray.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 14.03.2023.
//

import Foundation

@propertyWrapper
public struct LossyArray<Element: Decodable> {
    public var wrappedValue: [Element]

    public var elements: [Element] {
        wrappedValue
    }

    public init(wrappedValue: [Element]) {
        self.wrappedValue = wrappedValue
    }

    public init(elements: [Element]) {
        wrappedValue = elements
    }
}

// MARK: - Decodable

extension LossyArray: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let elements = try container.decode([FailableDecodable<Element>].self)
        wrappedValue = elements.compactMap(\.wrappedValue)
    }
}

extension LossyArray: Equatable where Element: Equatable {}
