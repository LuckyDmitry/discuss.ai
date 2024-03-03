//
//  RoundedTextField.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 24.05.2023.
//

import SwiftUI

struct RoundedTextField: View {
  @Binding var searchText: String
  let image: Image?
  var placeholder: String = ""
  
  var body: some View {
    HStack {
      TextField("", text: $searchText)
        .placeholder(
          when: searchText.isEmpty,
          placeholder: {
            Text(placeholder)
              .foregroundColor(Colors.TextAndIcons.gray2.color)
          }
        )
        .foregroundColor(.white)
        .frame(height: 48)
        .padding(.horizontal, 16)
        .background(Colors.Surface.grayTwo.color)
        .cornerRadius(24)
        .overlay(
          HStack {
            if searchText.isEmpty, let image {
              image
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 22)
            }
          }
        )
    }
    
  }
}

struct RoundedTextField_Previews: PreviewProvider {
  @State
  static var text = ""
  static var previews: some View {
    RoundedTextField(
      searchText: $text,
      image: Image(systemName: "magnifyingglass")
    )
  }
}
