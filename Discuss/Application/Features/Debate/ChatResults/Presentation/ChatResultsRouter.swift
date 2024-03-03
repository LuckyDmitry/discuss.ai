import Foundation
import Nivelir

@MainActor
struct ChatResultsRouter {
  let navigator: Navigator
  
  func exitDebate() {
    navigator.navigator.navigate(to: navigator.screens.showHomeRoute())
  }
  
  func goToNextRound() {
    navigator
      .navigator
      .navigate { route in
        route
          .first(.container(key: .debateChat))
          .makeVisible(stackAnimation: .crossDissolve)
      }
  }
  
  func analyzeMessages(_ debate: DebateQuestion, message: ChatIntermediateMessage) {
    let screen = navigator.screens.analyzeScreen(debate: debate, message: message)
    navigator.navigator.navigate { route in
      route
        .top(.stack)
        .push(screen)
    }
  }
  
  func finishDebate() {
    navigator.navigator.navigate(to: navigator.screens.showHomeRoute())
  }
}
