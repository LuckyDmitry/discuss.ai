import Foundation

@MainActor
struct ProfileRouter {
  
  private let navigator: Navigator
  
  init(navigator: Navigator) {
    self.navigator = navigator
  }
  
  func goToSettings() {
    navigator.navigator.navigate { route in
      route
        .top(.stack)
        .push(navigator.screens.settingsScreen().withHiddenTabBar())
    }
  }
}
