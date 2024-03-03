import SwiftUI

@MainActor
struct ProfileSettingsChooseLanguageView: View {
  let items: [Language]
  
  @State
  var chosen: Language
  var onFinish: (Language) -> Void
  var isTarget: Bool
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      PrimaryText(isTarget ? "Choose the language you want to learn" : "Choose your native language")
        .font(.sfPro(.bold, size: 20))
        .padding(.bottom, 4)
        .padding(.top, 32)
      Text("")
        .fixedSize(horizontal: false, vertical: true)
        .foregroundColor(Colors.TextAndIcons.gray2.color)
        .font(.sfPro(.regular, size: 14))
        .padding(.bottom, 28)
      ForEach(items) { item in
        SecondaryButton(
          title: item.title,
          isPressed: item == chosen,
          action: { chosen = item },
          style: .profile
        )
        .padding(.bottom, 16)
      }
      Spacer()
      PrimaryButton(action: {
          onFinish(chosen)
      }, text: "Save")
        .padding(.top, 40)
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 24)
  }
}
