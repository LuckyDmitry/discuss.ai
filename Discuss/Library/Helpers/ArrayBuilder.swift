//
//  ArrayBuilder.swift
//  ozonPvz
//
//  Created by Trifonov Dmitriy Aleksandrovich on 24.03.2023.
//

import Foundation

//@resultBuilder
//public enum ArrayBuilder<Element> {
//    static func buildPartialBlock(first: Element) -> [Element] {
//        [first]
//    }
//
//    static func buildPartialBlock(first: [Element]) -> [Element] {
//        first
//    }
//
//    static func buildPartialBlock(accumulated: [Element], next: Element) -> [Element] {
//        accumulated + CollectionOfOne(next)
//    }
//
//    static func buildPartialBlock(accumulated: [Element], next: [Element]) -> [Element] {
//        accumulated + next
//    }
//    static func buildBlock() -> [Element] {
//        []
//    }
//
//    static func buildEither(first: [Element]) -> [Element] {
//        first
//    }
//
//    static func buildEither(second: [Element]) -> [Element] {
//        second
//    }
//
//    static func buildIf(_ element: [Element]?) -> [Element] {
//        element ?? []
//    }
//}
//
//public extension Array {
//    init(@ArrayBuilder<Element> builder: () -> [Element]) {
//        self.init(builder())
//    }
//}
