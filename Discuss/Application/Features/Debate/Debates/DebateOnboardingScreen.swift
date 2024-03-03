import Foundation
import Nivelir
import UIKit
import SwiftUI

@MainActor
struct DebateOnboardingScreen: Screen {
  let services: Services
  let screens: Screens
  let debate: DebateQuestion
  
  func build(navigator: ScreenNavigator) -> UIViewController {
    fatalError()
//    let debateOnboardingView = DebateOnboardingView(
//      debate: debate,
//      onCloseTap: {
//      },
//      onNextTap: {
//        navigator.navigate { route in
//          route
//            .top(.stack)
//            .present(screens.chatScreen(debate: debate).withModalPresentationStyle(.fullScreen))
//        }
//      }
//    )
//
//    return UIHostingController(rootView: debateOnboardingView)
  }
}
