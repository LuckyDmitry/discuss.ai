//
//  PrimaryButton.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

struct PrimaryButton: View {
  enum ColorSheme {
    case blue
    case black
    case gray
    case custom(Color)
    
    var textColor: Color {
      switch self {
      case .black, .blue:
        return .white
      case .gray:
        return .black
      case let .custom(color):
        return color
      }
    }
    
    var enabled: Color {
      switch self {
      case .blue:
        return Asset.Colors.Surfaces.blue.swiftUIColor
      case .black:
        return Asset.Colors.Surfaces.Dark.gray2.swiftUIColor
      case .gray:
        return Asset.Colors.Surfaces.Light.gray2.swiftUIColor
      case let .custom(color):
        return color
      }
    }
    
    var disabled: Color {
      switch self {
      case .black:
        return Asset.Colors.Surfaces.Dark.gray2.swiftUIColor
      case .blue:
        return Asset.Colors.Surfaces.lightBlue.swiftUIColor
      case .gray:
        return Asset.Colors.Surfaces.Light.gray2.swiftUIColor
      case let .custom(color):
        return color
      }
    }
    
    var height: CGFloat {
      switch self {
      case .black, .custom:
        return 56
      case .blue, .gray:
        return 48
      }
    }
  }
  
  @Environment(\.isEnabled)
  private var isEnabled
  
  var action: () -> Void
  var text: String
  var colorSheme: ColorSheme = .blue
  
  var body: some View {
    Button(action: {
      simpleSuccess()
      action()
    }, label: {
      Text(text)
        .font(.sfPro(.semibold, size: 20))
        .foregroundColor(colorSheme.textColor)
        .frame(maxWidth: .infinity)
        .frame(height: colorSheme.height)
        .background(
          RoundedRectangle(cornerRadius: 24).fill(isEnabled ? colorSheme.enabled : colorSheme.disabled)
        )
    })
  }
}

struct PrimaryButton_Previews: PreviewProvider {
  static var previews: some View {
    PrimaryButton(action: {}, text: "Hello")
  }
}
