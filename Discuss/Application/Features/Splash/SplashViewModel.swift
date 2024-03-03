import Foundation

final class SplashViewModel: ObservableObject {
  private let services: Services
  private let navigator: Navigator
  
  init(services: Services, navigator: Navigator) {
    self.services = services
    self.navigator = navigator
  }
  
  func onAppear() {
    Task { @MainActor in
      if services.authService.userUid != nil {
        do {
          _ = try await services.profileService.getUserInfo()
          navigator.navigator
            .navigate(to: navigator.screens.showHomeRoute())
        } catch {
          navigator.navigator
            .navigate(to: navigator.screens.showOnboardingRoute())
        }
      } else {
        navigator.navigator
          .navigate(to: navigator.screens.showAuthorizationRoute())
      }
    }
  }
}
