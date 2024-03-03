//
//  SecondaryText.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 13.05.2023.
//

import SwiftUI

struct SecondaryText: View {
  var text: String
  
  init(_ text: String) {
    self.text = text
  }
  
  var body: some View {
    Text(text)
      .foregroundColor(Colors.TextAndIcons.gray1.color)
  }
}

struct SecondaryText_Previews: PreviewProvider {
  static var previews: some View {
    SecondaryText("")
  }
}
