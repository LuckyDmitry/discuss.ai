//
//  ProfileSettingsChooseLevelView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 07.05.2023.
//

import SwiftUI

@MainActor
struct ProfileSettingsChooseLevelView: View {
  private let items: [LanguageLevel] = LanguageLevel.allCases
  
  @State
  var chosen: LanguageLevel
  var onFinish: (LanguageLevel) -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      PrimaryText("Choose your English level")
        .font(.sfPro(.bold, size: 20))
        .padding(.bottom, 4)
        .padding(.top, 32)
      Text("You can improve your messages according to your level. For example, an advanced level allows you to use idioms")
        .fixedSize(horizontal: false, vertical: true)
        .foregroundColor(Colors.TextAndIcons.gray2.color)
        .font(.sfPro(.regular, size: 14))
        .padding(.bottom, 28)
      ForEach(items) { item in
        SecondaryButton(
          title: item.onboardingItem.title,
          isPressed: item == chosen,
          action: { chosen = item },
          leadingImage: item.onboardingItem.image,
          style: .profile
        )
        .padding(.bottom, 16)
      }
      PrimaryButton(action: {
          onFinish(chosen)
      }, text: "Save")
        .padding(.top, 40)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
  }
}

//struct ProfileSettingsChooseLevelView_Previews: PreviewProvider {
//    static var previews: some View {
//      ProfileSettingsChooseLevelView(chosen: .advanced, onLanguageLevelPressed: { _ in })
//        .blackBackground()
//    }
//}
