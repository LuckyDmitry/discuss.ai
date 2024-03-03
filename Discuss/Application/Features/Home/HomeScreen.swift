import Foundation
import Nivelir
import UIKit

struct HomeScreen: Screen {
  
  let services: Services
  let screens: Screens
  
  func build(navigator: ScreenNavigator) -> UITabBarController {
    let view = HomeTabBarController(
      screens: screens,
      screenKey: key,
      screenNavigator: navigator
    )
    
    navigator.navigate(from: view) { route in
      route
        .setupTab(
          with: screens
            .questiongsScreen()
            .withStackContainer()
            .withTabBarItem(.home)
        )
        .setupTab(
          with: screens
            .profileScreen()
            .withHiddenNavigationBarStackContainer()
            .withTabBarItem(.profile)
        )
        .selectTab(with: .index(0))
    }
    
    return view
  }
}
