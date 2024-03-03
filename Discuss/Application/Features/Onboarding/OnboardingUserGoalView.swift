//
//  OnboardingUserGoalView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

enum LanguageGoal: String, CaseIterable, Codable {
  case improvePronunciation
  case practiceSpeakingSkills
  case makeLessMistakes
  case learnNewWords
  case examPreparation
  
  var onboardingItem: OnboardingItem {
    switch self {
    case .improvePronunciation:
      return .init(image: Asset.Onboarding.pronunciation.swiftUIImage, title: "Improve pronunciation")
    case .practiceSpeakingSkills:
      return .init(image: Asset.Onboarding.barrier.swiftUIImage, title: "Practice speaking skills")
    case .makeLessMistakes:
      return .init(image: Asset.Onboarding.lessMistakes.swiftUIImage, title: "Make less mistakes")
    case .learnNewWords:
      return .init(image: Asset.Onboarding.newWords.swiftUIImage, title: "Learn new words")
    case .examPreparation:
      return .init(image: Asset.Onboarding.specificSituation.swiftUIImage, title: "Prepare for Language Exams")
    }
  }
}

struct OnboardingUserGoalView: View {
  var onUserGoalPressed: (LanguageGoal) -> Void
  
  let items: [LanguageGoal] = LanguageGoal.allCases
  
  var body: some View {
    VStack(spacing: 0) {
      OnboardingCommonQuestionVew(
        title: "What do you want to improve?",
        subtitle: "Knowing your goal — is a big part of the success"
      )
      .padding(.bottom, 56)
      
      ForEach(items, id: \.self.onboardingItem.title) { item in
        SecondaryButton(
          title: item.onboardingItem.title,
          action: {
            AnalyticsService.event(.onboardingChoseLanguageGoal(languageGoal: item))
            onUserGoalPressed(item)
          },
          leadingImage: item.onboardingItem.image
        )
        .padding(.bottom, 16)
      }
      Spacer()
    }
    .onAppear {
      AnalyticsService.screenAppear(.onboardingLanguageGoal)
    }
  }
}

struct OnboardingUserGoalView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingUserGoalView(onUserGoalPressed: { _ in })
  }
}
