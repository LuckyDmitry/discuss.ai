//
//  CapsuleTextField.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

struct CapsuleTextField: View {
  let placeholder: String
  
  @Binding
  var text: String
  
  var body: some View {
    TextField(placeholder, text: $text)
      .font(.sfPro(.regular, size: 16))
      .foregroundColor(Asset.Colors.TxtIcons.gray.swiftUIColor)
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 24)
          .fill(Asset.Colors.Surfaces.gray2.swiftUIColor)
      )
  }
}

struct CapsuleTextField_Previews: PreviewProvider {
    @State
    static var text: String = ""
    
    static var previews: some View {
        CapsuleTextField(
            placeholder: "Hello",
            text: $text
        )
    }
}
