//
//  OnboardingEnglishLevelView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

struct OnboardingItem {
  var image: Image
  var title: String
}

protocol Titleble {
  var title: String { get }
}

enum LanguageLevel: String, Identifiable, CaseIterable, Codable, Hashable, Titleble {
  var id: Self { self }
  
  case beginner
  case intermediate
  case advanced
  case professional
  
  var onboardingItem: OnboardingItem {
    switch self {
    case .beginner:
      return .init(
        image: Asset.Onboarding.justStarting.swiftUIImage,
        title: "I am just starting"
      )
    case .intermediate:
      return .init(
        image: Asset.Onboarding.canSpeak.swiftUIImage,
        title: "I can only speak on simple topics"
      )
    case .advanced:
      return .init(
        image: Asset.Onboarding.speakConfidently.swiftUIImage,
        title: "I'm ready to speak in my daily life"
      )
    case .professional:
      return .init(
        image: Asset.Onboarding.fluent.swiftUIImage,
        title: "I can talk about almost anything"
      )
    }
  }
  
  var title: String {
    switch self {
    case .beginner:
      return "Beginner"
    case .intermediate:
      return "Intermediate"
    case .advanced:
      return "Advanced"
    case .professional:
      return "Professional"
    }
  }
}


struct OnboardingEnglishLevelView: View {
  
  var onLanguageLevelPressed: (LanguageLevel) -> Void
  var targetLanguage: Language
  
  let items: [LanguageLevel] = LanguageLevel.allCases
  
  var body: some View {
    VStack(spacing: 0) {
      OnboardingCommonQuestionVew(
        title: "What is your \(targetLanguage.title) level?",
        subtitle: "We will personalize study plan according to your current \(targetLanguage.title) level"
      )
      .padding(.bottom, 56)
      
      ForEach(items) { item in
        SecondaryButton(
          title: item.onboardingItem.title,
          action: {
            AnalyticsService.event(.onboardingChoseLanguageLevel(languageLevel: item))
            onLanguageLevelPressed(item)
          },
          leadingImage: item.onboardingItem.image
        )
        .padding(.bottom, 16)
      }
      Spacer()
    }
    .onAppear {
      AnalyticsService.screenAppear(.onboardingLanguageLevel)
    }
  }
}

struct OnboardingEnglishLevelView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingEnglishLevelView(onLanguageLevelPressed: { _ in }, targetLanguage: .fr)
  }
}
