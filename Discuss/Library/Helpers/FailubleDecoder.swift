//
//  FailubleDecoder.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 14.03.2023.
//

import Foundation

@propertyWrapper
public struct FailableDecodable<Wrapped: Decodable>: Decodable {
    public var wrappedValue: Wrapped?

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            wrappedValue = try container.decode(Wrapped.self)
        } catch {
            let title = String(describing: Wrapped.self)

            var userInfo = [String: Any]()
            userInfo[NSUnderlyingErrorKey] = error
            userInfo[NSLocalizedDescriptionKey] = error.localizedDescription

//            let recordError = NSError(
//                domain: "LossyError.\(title)",
//                code: error.errorCode,
//                userInfo: userInfo
//            )
        }
    }

    public init(value: Wrapped?) {
        wrappedValue = value
    }
}

public extension Error {
    var errorCode: Int {
        let nsError = self as NSError
        return nsError.code
    }

    var underlying: Error? {
        let nsError = self as NSError
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}
