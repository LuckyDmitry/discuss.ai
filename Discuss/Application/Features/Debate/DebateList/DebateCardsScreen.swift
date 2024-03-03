import Foundation
import Nivelir
import UIKit
import SwiftUI

@MainActor
struct DebateCardsScreen: Screen {
  
  let services: Services
  let screens: Screens
  
  func build(navigator: ScreenNavigator) -> UIViewController {
    let viewModel = DebateCardsViewModel(
      router: .init(navigator: .init(screens: screens, navigator: navigator)),
      services: services
    )
    
    let cardsViewModel = DebateCardsView(viewContext: .init(viewModel: viewModel))
    return UIHostingController(rootView: cardsViewModel)
  }
}
