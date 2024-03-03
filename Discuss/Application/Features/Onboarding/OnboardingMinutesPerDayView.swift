//
//  OnboardingTopicsView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

enum UserSettingPracticePerDay: Codable, Equatable, CaseIterable, Identifiable {
  var id: Self {
    self
  }
  
  case casual
  case standart
  case serios
  
  var duration: Int {
    switch self {
    case .casual:
      return 10
    case .standart:
      return 15
    case .serios:
      return 30
    }
  }
  
  var onboardingItem: (title: String, subtitle: String) {
    switch self {
    case .casual:
      return ("Casual practice", "\(self.duration) minutes per day")
    case .standart:
      return ("Standart practice", "\(self.duration) minutes per day")
    case .serios:
      return ("Serious practice", "\(self.duration) minutes per day")
    }
  }
}

struct OnboardingMinutesPerDayView: View {
  
  var targetMinutesPressed: (UserSettingPracticePerDay) -> Void
  
  private var items: [UserSettingPracticePerDay] = UserSettingPracticePerDay.allCases
  
  init(targetMinutesPressed: @escaping (UserSettingPracticePerDay) -> Void) {
    self.targetMinutesPressed = targetMinutesPressed
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        OnboardingCommonQuestionVew(
          title: "What’s your practice goal?",
          subtitle: "This will help us keep you on track to reach your goals"
        )
        .padding(.bottom, 56)
        ForEach(items) { item in
          SecondaryButton(
            title: item.onboardingItem.title,
            subtitle: item.onboardingItem.subtitle,
            action: {
              AnalyticsService.event(.onboardingChoseMinutesPerDay(minutes: item.duration))
              targetMinutesPressed(item)
            }
          )
          .padding(.top, 16)
        }
        
        Spacer()
      }
    }
    .onAppear {
      AnalyticsService.screenAppear(.onboardingLanguageMinutesPerDay)
    }
  }
}

struct OnboardingMinutesPerDayView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingMinutesPerDayView(targetMinutesPressed: { _ in })
  }
}
