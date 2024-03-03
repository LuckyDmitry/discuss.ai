//
//  User.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 30.05.2023.
//

import Foundation

enum User: String, Hashable, Codable {
  case assistant
  case user
  
  var isUser: Bool {
    self == .user
  }
}
