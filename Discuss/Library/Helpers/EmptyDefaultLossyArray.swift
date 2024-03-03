//
//  EmptyDefaultLossyArray.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 14.03.2023.
//

import Foundation

@propertyWrapper
public struct DefaultEmptyLossyArray<Element: Decodable> {
    public var wrappedValue: [Element] {
        get { items.elements }
        set { items = .init(elements: newValue) }
    }

    private var items: LossyArray<Element>

    public init(wrappedValue: [Element]) {
        self.items = LossyArray<Element>(elements: wrappedValue)
    }
}

extension DefaultEmptyLossyArray: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        items = try container.decode(LossyArray<Element>.self)
    }
}

public extension KeyedDecodingContainer {
    /// Default implementation of decoding a DefaultEmptyLossyArray
    ///
    /// Decodes successfully if key is available if not fallsback to the empty array value
    func decode<P>(_: DefaultEmptyLossyArray<P>.Type, forKey key: Key) throws -> DefaultEmptyLossyArray<P> {
        if let value = try decodeIfPresent(DefaultEmptyLossyArray<P>.self, forKey: key) {
            return value
        } else {
            return DefaultEmptyLossyArray(wrappedValue: [])
        }
    }
}
