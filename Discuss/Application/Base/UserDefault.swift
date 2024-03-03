//
//  UserDefault.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 02.06.2023.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    private var key: String
    private var initialValue: T?

    init(key: String, initialValue: T? = nil) {
        self.key = key
        self.initialValue = initialValue
    }

    var wrappedValue: T? {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return initialValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? initialValue
        }
        set {
            if newValue == nil {
                UserDefaults.standard.removeObject(forKey: key)
            } else {
                let data = try? JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
}
