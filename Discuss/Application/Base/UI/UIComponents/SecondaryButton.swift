//
//  SecondaryButton.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

enum SecondaryButtonStyle {
  case onboarding
  case profile
  
  var pressedColor: Color {
    switch self {
    case .onboarding:
        return Asset.Colors.Surfaces.ultraLightBlue.swiftUIColor
    case .profile:
        return Asset.Colors.Surfaces.blue.swiftUIColor
    }
  }
}

struct SecondaryButton: View {
  var title: String
  var subtitle: String? = nil
  var isPressed: Bool = false
  var action: () -> Void
  var leadingImage: Image? = nil
  var chevronNeeded = false
  var isRedacted = false
  var style: SecondaryButtonStyle = .onboarding
  var needsToExpand: Bool = true
  
  var body: some View {
    Button(action: {
      simpleSuccess()
      action()
    }) {
      HStack(spacing: 8) {
        Group {
          if let leadingImage {
            leadingImage
              .resizable()
              .frame(width: 24, height: 24)
          }
          VStack(spacing: 8) {
            Text(isRedacted ? "PlaceholderPlaceholder" : title)
              .multilineTextAlignment(.leading)
              .redacted(reason: isRedacted ? .placeholder : .init())
              .font(isRedacted ? .system(size: 16) : .sfPro(.bold, size: 16))
              .frame(maxWidth: needsToExpand ? .infinity : nil, alignment: .leading)
              .foregroundColor(Asset.Colors.TxtIcons.gray.swiftUIColor)
            
            if let subtitle {
              Text(subtitle)
                .font(.sfPro(.regular, size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Asset.Colors.TxtIcons.gray2.swiftUIColor)
            }
          }
          .padding(.vertical, 16)
          
          if chevronNeeded {
            Image(systemName: "chevron.right")
              .foregroundColor(Asset.Colors.TxtIcons.gray.swiftUIColor)
              .padding(.leading, 16)
          }
        }
      }
      .padding(.horizontal, 17)
      .background(RoundedRectangle(cornerRadius: 20).fill(isPressed ? style.pressedColor : Asset.Colors.Surfaces.gray3.swiftUIColor))
    }
    .frame(minHeight: 52)
  }
}

struct SecondaryButton_Previews: PreviewProvider {
  static var previews: some View {
    SecondaryButton(
      title: "I can only speak on simple topics",
      subtitle: "Learning",
      action: {},
      leadingImage: Asset.Onboarding.fluent.swiftUIImage,
      chevronNeeded: true,
      isRedacted: true
    )
  }
}

func simpleSuccess() {
  let generator = UINotificationFeedbackGenerator()
  generator.notificationOccurred(.success)
}
