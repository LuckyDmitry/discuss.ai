import UIKit
import Nivelir
import SwiftUI

@MainActor
struct SplashScreen: Screen {
  
  let services: Services
  let screens: Screens
  
  func build(navigator: ScreenNavigator) -> UIViewController {
    UIHostingController(rootView: SplashView(viewModel: .init(services: services, navigator: Navigator(screens: screens, navigator: navigator))))
  }
}
