import Foundation
import Nivelir
import UIKit
import SwiftUI

@MainActor
struct ChatResultsScreen: Screen {
  
  let services: Services
  let screens: Screens
  let messages: [ChatIntermediateMessage]
  let debate: DebateQuestion
  
  func build(navigator: ScreenNavigator) -> UIViewController {
    let router = ChatResultsRouter(navigator: .init(screens: screens, navigator: navigator))
    let useCase = ChatResultsUseCase(services: services)
    let viewModel = ChatResultsViewModel(
      messages: messages,
      debateQuestion: debate,
      router: router,
      useCase: useCase
    )
    return UIHostingController(rootView: ChatResultsView(viewContext: .init(viewModel: viewModel)))
  }
}
