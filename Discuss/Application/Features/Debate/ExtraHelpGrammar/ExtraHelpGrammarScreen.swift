import Nivelir
import Foundation
import SwiftUI

@MainActor
struct ExtraHelpScreen: Screen {
  var debate: DebateQuestion
  var services: HasTranslationService & HasProfileService

  func build(navigator: ScreenNavigator) -> UIViewController {
    let router = makeRouter(navigator)
    let useCase = ExtraHelpUseCase(services: services, debate: debate)
    let viewModel = ExtraHelpViewModel(router: router, useCase: useCase)
    
    let view = ExtraHelpView(
      viewContext: ViewContext(viewModel: viewModel)
    )
    return UIHostingController(rootView: view)
  }
  
  private func makeRouter(_ navigator: ScreenNavigator) -> ExtraHelpRouter {
    ExtraHelpRouter(onOkay: {
      navigator.topContainer?.dismiss(animated: true)
    })
  }
  
  // MARK: Routes
  
  static func showRoute() -> ScreenWindowRoute {
    ScreenWindowRoute { route in
      route
    }
  }
}
