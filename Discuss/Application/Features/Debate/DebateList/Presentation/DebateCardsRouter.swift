//
//  DebateCardsRouter.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 16/10/2023.
//

import Foundation

@MainActor
struct DebateCardsRouter {
  var navigator: Navigator
  
  func changeTabBarVisibility(hidden: Bool) {
    navigator.navigator.topTabsContainer?.tabBar.isHidden = hidden
  }
  
  func showDebate(_ debate: DebateQuestion, isAgainst: Bool) {
    navigator
      .navigator.navigate { route in
        route
          .first(.stack)
          .present(navigator.screens.chatScreen(debate: debate, isAgainst: isAgainst).withHiddenNavigationBarStackContainer() .withModalPresentationStyle(.fullScreen))
      }
  }
  
  func showHints(_ debate: DebateQuestion) {
    navigator
      .navigator.navigate { route in
        route
          .first(.stack)
          .present(navigator.screens.extraHelpScreen(debate: debate))
      }
  }
}
