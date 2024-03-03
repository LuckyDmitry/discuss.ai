import Nivelir
import Foundation
import SwiftUI

@MainActor
struct AnalizeAnswerScreen: Screen {
  
  var services: Services
  var debate: DebateQuestion
  var message: ChatIntermediateMessage
  
  func build(navigator: ScreenNavigator) -> UIViewController {
    let router = makeRouter(navigator)
    let useCase = AnalizeAnswerUseCase(
      services: services,
      debate: debate,
      message: message
    )
    let viewModel = AnalizeAnswerViewModel(
      router: router,
      useCase: useCase
    )
    
    let view = AnalizeAnswerView(
      viewContext: ViewContext(viewModel: viewModel)
    )
    return UIHostingController(rootView: view)
  }
  
  private func makeRouter(_ navigator: ScreenNavigator) -> AnalizeAnswerRouter {
    AnalizeAnswerRouter()
  }
  
  // MARK: Routes
  
  static func showRoute(debate: DebateQuestion, message: ChatIntermediateMessage) -> ScreenWindowRoute {
    ScreenWindowRoute { route in
      route
    }
  }
}
