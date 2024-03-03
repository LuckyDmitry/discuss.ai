import Foundation

@MainActor
struct ProfileSettingsRouter {
  private let navigator: Navigator
  
  init(navigator: Navigator) {
    self.navigator = navigator
  }
  
  func goToAuth() {
    navigator.navigator.navigate(to: navigator.screens.showAuthorizationRoute())
  }
  
  func goBack() {
    navigator.navigator.navigate { route in
      route
        .top(.stack)
        .pop(animation: .default)
    }
  }
}
