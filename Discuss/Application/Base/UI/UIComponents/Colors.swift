//
//  Colors.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 23.04.2023.
//

import Foundation
import UIKit
import SwiftUI

enum Colors {
  enum Surface {
    static let lightBlue = UIColor(r: 131, g: 172, b: 252)
    static let grayOne = UIColor(r: 37, g: 38, b: 38)
    static let grayTwo = UIColor(r: 54, g: 51, b: 57)
    static let grayThree = UIColor(r: 223, g: 225, b: 229)
    static let blue = UIColor(r: 53, g: 116, b: 240)
    static let darkBlue = UIColor(r: 55, g: 95, b: 173)
    static let lilac = UIColor(r: 183, g: 159, b: 209)
    static let mint = UIColor(r: 178, g: 228, b: 225)
    static let lightGreen = UIColor(r: 160, g: 219, b: 165)
    static let lightYellow = UIColor(r: 247, g: 222, b: 139)
    static let statusRed = UIColor(r: 219, g: 92, b: 92)
  }
  
  enum Background {
    static let main = UIColor(r: 30, g: 33, b: 33)
  }
  
  enum TextAndIcons {
    static let accent = UIColor(r: 53, g: 116, b: 240)
    static let white = UIColor(r: 255, g: 255, b: 255)
    static let gray2 = UIColor(r: 121, g: 118, b: 125)
    static let gray1 = UIColor(r: 39, g: 42, b: 50)
  }
  
  enum Gradient {
    static let blue: [UIColor] = [
      .init(r: 153, g: 187, b: 255),
      .init(r: 53, g: 116, b: 240)
    ]
  }
}

extension UIColor {
    var color: Color {
        Color(uiColor: self)
    }
}

extension Array where Element == UIColor {
  var colors: [Color] {
    self.map { $0.color }
  }
}
