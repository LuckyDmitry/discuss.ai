//
//  OnboardingTopicsView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import SwiftUI

enum DebateTopic: String, Identifiable, CaseIterable, Codable, Equatable, Titleble {
  var id: Self {
    self
  }
  
  case environment
  case technology
  case health
  case ethics
  case law
  case society
  case science
  case politics
  case education
  case sports
  case food
  case history
  case immigration
  case art
  case language
  case work
    
  var title: String {
    switch self {
    case .work:
      return "Work"
    case .environment:
      return "Environment"
    case .technology:
      return "Technology"
    case .health:
      return "Health"
    case .ethics:
      return "Ethics"
    case .language:
      return "Language"
    case .law:
      return "Law"
    case .society:
      return "Society"
    case .science:
      return "Science"
    case .politics:
      return "Politics"
    case .education:
      return "Education"
    case .sports:
      return "Sports"
    case .food:
      return "Food"
    case .history:
      return "History"
    case .immigration:
      return "Immigration"
    case .art:
      return "Art"
    }
  }
}

struct OnboardingTopicsView: View {
  
  var nextButtonPressed: ([DebateTopic]) -> Void
  
  let items = DebateTopic.allCases
  
  @State
  private var chosen: [DebateTopic] = []
  
  var body: some View {
    ZStack(alignment: .bottom) {
      ScrollView {
        VStack(spacing: 0) {
          OnboardingCommonQuestionVew(
            title: "What topics do you want to practice?",
            subtitle: "This will help us adjust topics to match your interests"
          )
          .padding(.bottom, 56)
          
          LazyVGrid(columns: [
            .init(.flexible()),
            .init(.flexible())
          ], spacing: 0) {
            ForEach(items, id: \.self) { item in
              SecondaryButton(
                title: item.title,
                isPressed: chosen.contains(item),
                action: {
                  if chosen.contains(item) {
                    chosen.removeAll { item == $0 }
                  } else {
                    chosen.append(item)
                  }
                }
              )
              .padding(.bottom, 16)
            }
          }
          
          Spacer()
        }
        .padding(.horizontal, 24)
      }
      PrimaryButton(action: {
        AnalyticsService.event(.onboardingChoseTopics(topics: chosen))
        nextButtonPressed(chosen)
      }, text: "Next")
      .padding(.horizontal, 24)
    }
    .onAppear {
      AnalyticsService.screenAppear(.onboardingLanguageTopics)
    }
  }
}

struct OnboardingTopicsView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingTopicsView(nextButtonPressed: { _ in })
  }
}
