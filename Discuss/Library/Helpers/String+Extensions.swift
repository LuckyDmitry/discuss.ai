//
//  String+Extensions.swift
//  Elizabeth
//
//  Created by Дмитрий Трифонов on 07/08/2023.
//

import Foundation

extension String {

  public func customSplit(byCharacters characters: String) -> [String] {
    var substrings: [String] = []
    
    var currentSubstring = ""
    for char in self {
      if characters.contains(char) {
        if !currentSubstring.isEmpty {
          currentSubstring.append(char)
          substrings.append(currentSubstring)
          currentSubstring = ""
        }
      } else {
        currentSubstring.append(char)
      }
    }
    
    if !currentSubstring.isEmpty {
      substrings.append(currentSubstring)
    }
    
    return substrings
  }
}
