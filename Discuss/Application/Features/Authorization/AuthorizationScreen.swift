import UIKit
import Nivelir
import SwiftUI

@MainActor
struct AuthorizationScreen: Screen {
  
  let services: Services
  let screens: Screens
  
  func build(navigator: ScreenNavigator) -> UIViewController {
    UIHostingController(rootView: AuthView(authViewModel: AuthViewModel(
      services: services,
      screenNavigator: navigator,
      screens: screens
    )))
  }
}
