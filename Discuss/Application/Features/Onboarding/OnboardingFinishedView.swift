//
//  OnboardingFinishedView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 07.05.2023.
//

import SwiftUI
import ActivityIndicatorView

struct OnboardingFinishedView: View {
  typealias Services = HasProfileService & HasAuthService
  let navigator: Navigator
  
  @State
  private var percentage = 0
  
  var userInfo: UserProfileInfo
  private var services: Services
  
  init(
    navigator: Navigator,
    userInfo: UserProfileInfo,
    services: Services
  ) {
    self.navigator = navigator
    self.userInfo = userInfo
    self.services = services
  }
  
  var body: some View {
    VStack {
      OnboardingCommonQuestionVew(
        title: "Forming your study plan",
        subtitle: ""
      )
      Spacer()
      ZStack {
        PrimaryText("\(percentage)%")
          .sfPro(.regular, size: 14)
        ActivityIndicatorView(isVisible: .constant(true), type: .arcs())
          .frame(width: 100, height: 100)
      }
      Spacer()
    }
    .onAppear {
      Task {
        try await services.profileService.saveUserInfo(userInfo)
      }
      AnalyticsService.screenAppear(.onboardingFinish)
      animatePercentage()
    }
  }
  
  func animatePercentage() {
    Task { @MainActor in
      try await services.profileService.saveUserInfo(userInfo)
      navigator.navigator.navigate(to: navigator.screens.showSplashRoute())
    }
    for i in 1...100 {
      DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.01) {
        percentage = i
      }
    }
  }
}

//struct OnboardingFinishedView_Previews: PreviewProvider {
//  static var previews: some View {
//    OnboardingFinishedView(onFinished: {}, userInfo: .init(name: "", nativeLanguage: "", languageLevel: .advanced, userGoal: "", userTopics: [], practicePerDay: .casual))
//  }
//}
