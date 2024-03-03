//
//  DebateCardsViewModel.swift
//  Elizabeth
//
//  Created by Дмитрий Трифонов on 09/09/2023.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class DebateCardsViewModel: BaseViewModel {
  typealias State = DebateViewState
  typealias Action = DebateViewAction
  typealias Services = HasAuthService & HasQuestionsProvider & HasProfileService
  
  private let router: DebateCardsRouter
  private let services: Services
  
  let state: CurrentValueSubject<DebateViewState, Never>
  private var profileListenerUuid: UUID?
  private var cancellables = Set<AnyCancellable>()
  
  private var currentQuestion: DebateQuestion {
    guard let question = self.state.value.content?.questions.first else {
      assertionFailure()
      return .random()
    }
    return question
  }
  
  init(router: DebateCardsRouter, services: Services) {
    self.router = router
    self.services = services
    self.state = .init(.loading)
  }
  
  func handle(_ action: DebateViewAction) {
    Task {
      switch action {
      case .onAppear:
        await onAppear()
      case .tapOnClose:
        AnalyticsService.event(.skipCard(currentQuestion.title))
        tapOnClose()
      case .tapOnLanguageLevel:
        break
      case .tapOnCard:
        AnalyticsService.event(.tapOnCard(currentQuestion.title))
      case .tapOnHint:
        router.showHints(currentQuestion)
      case .tapOnCloseDetailCard:
        AnalyticsService.screenAppear(.detailCards)
      case .topOnFilter:
        break
      case let .viewDisplayChanged(detailed: detailed):
        router.changeTabBarVisibility(hidden: detailed)
      case .languageLevelChosen(_):
        // TODO: Add updating language level
        break
      case let .tapOnStartBattle(against: isAgainst, question):
        if isAgainst {
          AnalyticsService.event(.tapOnOpposite(question.title))
        } else {
          AnalyticsService.event(.tapOnSupport(question.title))
        }
        router.showDebate(currentQuestion, isAgainst: isAgainst)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
          self?.modify {
            $0.update { $0.questions.removeFirst() }
          }
        }
      case .topicChosen(_):
        // TODO: Add updating topic
        break
      case .tapOnReloadCards:
        await loadQuestions()
      }
    }
  }
  
  private func onAppear() async {
    await loadQuestions()
    let (uuid, subscription) = services.profileService.subscribeToUserInfo()
    profileListenerUuid = uuid
    subscription
      .sink { [weak self] _ in
        Task {
          await self?.loadQuestions()
        }
      }
      .store(in: &cancellables)
    
    AnalyticsService.screenAppear(.cards)
  }
  
  deinit {
    if let profileListenerUuid {
      services.profileService.unsubscribeToUserInfo(uuid: profileListenerUuid)
    }
  }
  
  private func loadQuestions() async {
    do {
      modify {
        $0 = .loading
      }
      
      // TODO: Add loading questions by level and topic. Now it's mocked because we don't show them on main screen
      let questions = try await self.services.topicsProvider.getQuestions(level: .advanced, topic: .art)
      guard !questions.isEmpty else {
        modify {
          $0 = .error
        }
        return
      }
      modify {
        $0 = .content(DebateViewContent(questions: questions))
      }
    } catch {
      modify {
        $0 = .error
      }
    }
  }
  
  private func tapOnClose() {
    modify {
      $0.update { $0.questions.removeFirst() }
    }
  }
}
