import UIKit
import Nivelir
import SwiftUI

@MainActor
struct SettingsScreen: Screen {
  
  let services: Services
  let screens: Screens
  
  func build(navigator: ScreenNavigator) -> UIViewController {
    let viewModel = ProfileSettingsViewModel(services: services, router: .init(navigator: .init(screens: screens, navigator: navigator)))
    return UIHostingController(rootView: ProfileSettingsView(viewContext: .init(viewModel: viewModel)))
  }
}
