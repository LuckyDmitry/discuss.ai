import SwiftUI

//enum ChangeLanguageLevel: String, CaseIterable, Identifiable {
//  var id: Self {
//    self
//  }
//
//  case a1 = "Begginer A1"
//  case a2 = "Pre-intermediate A2"
//  case b1 = "Intermediate B1"
//  case b2 = "Upper-intermediate B2"
//  case c1 = "Advanced C1"
//  case c2 = "Proficiency C2"
//}

struct ChangeLanguageLevelView: View {
  
  @State
  var currentLanguageLevel: LanguageLevel
  var onChooseLanguageLevel: (LanguageLevel) -> Void
  
  var body: some View {
    ChangePreferenceViewView(
      title: "Choose your level",
      subtitle: "You can improve your messages according to your level. For example, an advanced level allows you to use idioms",
      preferences: LanguageLevel.allCases,
      onChoosePreference: onChooseLanguageLevel,
      currentPreference: currentLanguageLevel
    )
  }
}

struct ChangeLanguageLevelView_Previews: PreviewProvider {
  static var previews: some View {
    ChangeLanguageLevelView(
      currentLanguageLevel: .beginner,
      onChooseLanguageLevel: { _ in }
    )
  }
}
