import Foundation
import Nivelir
import UIKit
import SwiftUI

@MainActor
struct ChatScreen: Screen {
  
  let services: Services
  let screens: Screens
  let debate: DebateQuestion
  let isAgainst: Bool
  let totalRounds = 5
  
  func build(navigator: ScreenNavigator) -> UIViewController {
    services.chatMessageHistoryService.clear()
    services.chatMessageHistoryService.debateQuestion = debate
    let chatUseCase = ChatUseCase(
      services: services,
      interceptor: ChatDebateInterceptor(
      debate: debate,
      isAgainst: isAgainst,
      totalRounds: totalRounds
    ),
      evaluatorInterceptor: ChatEvaluatorInterceptor(
        debate: debate,
        isAgainst: isAgainst
      )
    )
    let chatViewModel = ChatViewModel(
      chatRouter: ChatRouter(navigator: .init(screens: screens, navigator: navigator), debate: debate),
      chatUseCase: chatUseCase,
      totalRounds: totalRounds,
      debateQuestion: debate.title
    )
    return UIHostingKeyedViewController(rootView: ChatView(viewContext: .init(viewModel: chatViewModel)), screenKey: .debateChat)
  }
}
