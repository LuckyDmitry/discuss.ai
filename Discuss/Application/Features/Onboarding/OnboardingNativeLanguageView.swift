//
//  OnboardingNativeLanguage.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

struct OnboardingNativeLanguage: View {
  let nativeLanguages = Language.allCases
  var onNativeLanguageTapped: (Language) -> Void
  
  var body: some View {
    VStack(spacing: 0) {
      OnboardingCommonQuestionVew(
        title: "What is your \n native language?",
        subtitle: "You will get hints and translations in your native language during conversations"
      )
      .padding(.bottom, 56)
      
      ForEach(nativeLanguages, id: \.self) { language in
        SecondaryButton(
          title: language.title,
          action: {
            AnalyticsService.event(.onboardingChoseNativeLanguage(language.rawValue))
            onNativeLanguageTapped(language)
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

struct OnboardingNativeLanguage_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingNativeLanguage(onNativeLanguageTapped: { _ in })
  }
}
