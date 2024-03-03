import SwiftUI
import Foundation
import Nivelir

@MainActor
final class AuthViewModel: ObservableObject {
  typealias Services = HasAuthService
  
  @Published
  var errorMessage: String?
  
  private let screenNavigator: ScreenNavigator
  private let screens: Screens
  private let services: Services
  
  init(services: Services, screenNavigator: ScreenNavigator, screens: Screens) {
    self.services = services
    self.screenNavigator = screenNavigator
    self.screens = screens
  }
  
  func googleSignInPressed() {
    Task { @MainActor in
      do {
        try await services.authService.signInWithGoogle()
        screenNavigator.navigate(to: screens.showSplashRoute())
      } catch {
        self.errorMessage = error.localizedDescription
      }
    }
  }
}
