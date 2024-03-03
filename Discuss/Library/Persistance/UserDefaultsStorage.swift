//
//  UserDefaultsStorage.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 20.05.2023.
//

import Foundation

final class UserDefaultsStorage {
  private let userDefaults: UserDefaults
  
  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }
  
  func save<T>(_ value: T, key: String) {
    userDefaults.set(value, forKey: key)
  }
  
  func erase(key: String) {
    userDefaults.removeObject(forKey: key)
  }
  
  func load<T>(key: String) -> T? {
    userDefaults.object(forKey: key) as? T
  }
}
