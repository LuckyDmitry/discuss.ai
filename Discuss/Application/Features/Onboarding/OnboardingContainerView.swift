//
//  OnboardingContainer.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 02.05.2023.
//

import SwiftUI

struct OnboardingContainer: View {
  typealias Services = HasProfileService & HasAuthService
  
  let navigator: Navigator
  
  @State
  private var name: String = ""
  
  @State
  private var nativeLanguage: Language = .en
  
  @State
  private var targetLanguage: Language = .fr
  
  @State
  private var languageLevel: LanguageLevel = .beginner
  
  @State
  private var userTopics: [DebateTopic] = []
  
  @State
  private var userGoal: LanguageGoal = .examPreparation
  
  @State
  private var practicePerDay: UserSettingPracticePerDay = .casual
  
  private var userInfo: UserProfileInfo {
    .init(
      name: name,
      nativeLanguage: nativeLanguage,
      learningLanguage: targetLanguage,
      languageLevel: languageLevel,
      userGoal: userGoal,
      userTopics: userTopics,
      practicePerDay: practicePerDay,
      notificationTime: nil
    )
  }
  
  private let services: Services
  
  init(services: Services, navigator: Navigator) {
    self.services = services
    self.navigator = navigator
  }
  
  @State
  private var index: Int = 0
  
  var views: [AnyIdentifiableView] {
    [
      AnyIdentifiableView(OnboardingNameIntroduction(
        name: $name,
        onNextTap: { withAnimation { index += 1 } }
      )),
      AnyIdentifiableView(OnboardingNativeLanguage(
        onNativeLanguageTapped: { nativeLanguage in
          self.nativeLanguage = nativeLanguage
          withAnimation {
            index += 1
          }
        }
      )),
//      AnyIdentifiableView(OnboardingTargetLanguage(
//        onTargetLanguageTapped: { targetLanguage in
//          self.targetLanguage = targetLanguage
//          withAnimation {
//            index += 1
//          }
//        },
//        excludeLanguage: $nativeLanguage
//      )),
      AnyIdentifiableView(OnboardingEnglishLevelView(
        onLanguageLevelPressed: { languageLevel in
          self.languageLevel = languageLevel
          withAnimation {
            index += 1
          }
        },
        targetLanguage: .fr
      )),
      
      AnyIdentifiableView(OnboardingUserGoalView(onUserGoalPressed: { userGoal in
        self.userGoal = userGoal
        withAnimation {
          index += 1
        }
      })),
      
      AnyIdentifiableView(OnboardingMinutesPerDayView(targetMinutesPressed: {
        self.practicePerDay = $0
        withAnimation {
          index += 1
        }
      })),
      
      AnyIdentifiableView(OnboardingTopicsView(nextButtonPressed: { topics in
        self.userTopics = topics
        withAnimation {
          index += 1
        }
      })),
      
      AnyIdentifiableView(OnboardingFinishedView(
        navigator: navigator,
        userInfo: userInfo,
        services: services
      )),
    ]
  }
  
  var body: some View {
    VStack {
      if index != views.count - 1 {
        HStack(spacing: 14) {
            ZStack { 
              Circle()
                .fill(.white)
                .frame(width: 23, height: 23)
                .onTapGesture {
                  if index == 0 {
                    Task {
                      try await services.authService.signOut()
                    }
                    navigator.navigator.navigate(to: navigator.screens.showAuthorizationRoute())
                  } else {
                    withAnimation {
                      index -= 1
                    }
                  }
                }
              if index == 0 {
                Image(systemName: "xmark")
                  .foregroundColor(Colors.TextAndIcons.gray2.color)
                  .transition(.scale)
              } else {
                Image(systemName: "chevron.left")
                  .foregroundColor(Colors.TextAndIcons.gray2.color)
                  .transition(.scale)
              }
            }
          
          ProgressView(
            value: CGFloat(index),
            total: CGFloat(views.count)
          )
          .tint(Asset.Colors.Surfaces.blue.swiftUIColor)
          .progressViewStyle(LinearProgressViewStyle())
          .frame(height: 8)
        }
      }
      ZStack {
        ForEach(views.viewEnumerated, id: \.index) { view in
          if view.index == self.index {
            view.element
              .transition(.push(from: .trailing))
          }
        }
      }
    }
    .padding(.horizontal, 24)
  }
}

//struct OnboardingContainer_Previews: PreviewProvider {
//  static var previews: some View {
//    OnboardingContainer(services: {})
//  }
//}

extension Array {
  struct Enumeration {
    var index: Int
    var element: Element
  }
  
  var viewEnumerated: [Enumeration] {
    self.enumerated().map {
      .init(index: $0.offset, element: $0.element)
    }
  }
}
