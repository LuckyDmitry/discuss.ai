import Foundation
import Nivelir
import UIKit
import SwiftUI

@MainActor
struct ProfileScreen: Screen {

    let services: Services
    let screens: Screens

    func build(navigator: ScreenNavigator) -> UIViewController {
      let navigator = Navigator(screens: screens, navigator: navigator)
      let settingsViewModel = ProfileViewModel(services: services, router: .init(navigator: navigator))
      return UIHostingController(rootView: ProfileView(viewContext: .init(viewModel: settingsViewModel)))
    }
}
