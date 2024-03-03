//
//  OnboardingNativeLanguage.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

enum Language: String, CaseIterable, Identifiable, Codable {
  
  var id: Self { self }
  
  case ru
  case en
  case tu
  case fr
  
  var title: String {
    switch self {
    case .en:
      return "English"
    case .fr:
      return "French"
    case .ru:
      return "Russian"
    case .tu:
      return "Turkish"
    }
  }
}

struct OnboardingTargetLanguage: View {
  let targetLanguages = Language.allCases
  
  var onTargetLanguageTapped: (Language) -> Void
  
  @Binding
  var excludeLanguage: Language
  
  var body: some View {
    VStack(spacing: 0) {
      OnboardingCommonQuestionVew(
        title: "What language do you want to learn?",
        subtitle: ""
      )
      .padding(.bottom, 56)
      
      ForEach(targetLanguages.filter { $0 != excludeLanguage }, id: \.self) { language in
        SecondaryButton(
          title: language.title,
          action: {
            onTargetLanguageTapped(language)
          })
        .padding(.bottom, 16)
      }
      Spacer()
    }
    .onAppear {
      AnalyticsService.screenAppear(.onboardingNativeLanguage)
    }
  }
}
