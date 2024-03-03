import Foundation

@MainActor
struct ChatRouter {
  
  let navigator: Navigator
  let debate: DebateQuestion
  
  func onExitLesson() {
    navigator.navigator.navigate(to: navigator.screens.showHomeRoute())
  }
  
  func onLessonFinished(messages: [ChatIntermediateMessage]) -> Void {
    navigator
      .navigator.navigate { route in
        route
          .top(.stack)
          .present(navigator.screens.chatResults(debate: debate, messages: messages).withModalPresentationStyle(.fullScreen))
      }
  }
}
