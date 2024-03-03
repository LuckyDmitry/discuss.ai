//
//  ContentMessageView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 25.03.2023.
//

import SwiftUI

struct ContentMessageView<Content: View>: View {
  var isLeadingAlignment: Bool
  var isSuggest: Bool
  var content: Content
  
  init(isLeadingAlignment: Bool, isSuggest: Bool = false, @ViewBuilder content: () -> Content) {
    self.isLeadingAlignment = isLeadingAlignment
    self.isSuggest = isSuggest
    self.content = content()
  }

  var body: some View {
    content
    .padding(10)
    .background(color)
    .cornerRadius(15, corners: [
      (!isLeadingAlignment ? .bottomLeft : .bottomRight),
      .topLeft,
      .topRight,
    ])
    .shadow(radius: 2, y: 1)
  }
  
  private var color: Color {
    if isSuggest {
      return Asset.Colors.Surfaces.Dark.mint.swiftUIColor
//      return Color(red: 248 / 255, green: 238 / 255, blue: 204 / 255)
    }
    
    return isLeadingAlignment ? Asset.Colors.Surfaces.Light.gray3.swiftUIColor : Asset.Colors.Surfaces.blue.swiftUIColor
  }
}
