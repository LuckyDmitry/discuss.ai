//
//  OnboardingNameIntroduction.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 02.05.2023.
//

import SwiftUI

struct OnboardingNameIntroduction: View {
  @Binding
  var name: String
  
  var onNextTap: () -> Void
  
  @FocusState
  private var isUsernameFocused: Bool
  
  var body: some View {
    VStack(spacing: 0) {
      OnboardingCommonQuestionVew(
        title: "What is your name?",
        subtitle: "Elizabeth will refer to you by this name"
      )
      CapsuleTextField(
        placeholder: "",
        text: $name
      )
      .autocorrectionDisabled()
      .focused($isUsernameFocused)
      .padding(.top, 32)
      Spacer()
      
      PrimaryButton(action: {
        isUsernameFocused = false
        AnalyticsService.event(.onboardingEnteredName)
        onNextTap()
      }, text: "Next")
      .disabled(name.filter { $0.isLetter }.isEmpty)
      .padding(.vertical)
      
    }
    .onAppear {
      isUsernameFocused = true
      AnalyticsService.screenAppear(.onboardingName)
    }
  }
}

struct OnboardingNameIntroduction_Previews: PreviewProvider {
  @State
  static var name = "12"
  
  static var previews: some View {
    OnboardingNameIntroduction(name: $name, onNextTap: {})
      .background(Colors.Background.main.color)
  }
}
