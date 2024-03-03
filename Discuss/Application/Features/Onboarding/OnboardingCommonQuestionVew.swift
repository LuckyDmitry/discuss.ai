//
//  OnboardingCommonQuestionVew.swift.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

struct OnboardingCommonQuestionVew: View {
  var title: String
  var subtitle: String
  
  var body: some View {
    VStack(spacing: 0) {
      PrimaryText(title)
        .sfPro(.heavy, size: 32)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.top, 82)
        .fixedSize(horizontal: false, vertical: true)
      
      PrimaryText(subtitle)
        .sfPro(.regular, size: 16)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
        .fixedSize(horizontal: false, vertical: true)
    }
  }
}

struct OnboardingQuestionVIew_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingCommonQuestionVew(
      title: "What is your native language?",
      subtitle: "You will get hints and translations in your native language during conversations"
    )
  }
}
