//
//  PrimaryText.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

struct PrimaryText: View {
  var text: String
  
  init(_ text: String) {
    self.text = text
  }
  var body: some View {
    Text(text)
      .foregroundColor(Colors.TextAndIcons.gray1.color)
  }
}

extension PrimaryText {
  func sfPro(_ name: SFProFonts, size: CGFloat) -> some View {
    self
      .font(Font.custom(name.rawValue, size: size))
  }
}

struct PrimaryText_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryText("Hello")
    }
}
