import Foundation
import Nivelir
import UIKit
import SwiftUI

@MainActor
struct Navigator {
    let screens: Screens
    let navigator: ScreenNavigator
}

struct OnboardingScreen: Screen {
    
    let services: Services
    let screens: Screens
    
    func build(navigator: ScreenNavigator) -> UIViewController {
        UIHostingController(rootView: OnboardingContainer(
            services: services,
            navigator: Navigator(screens: screens, navigator: navigator)
        ))
    }
}

extension Navigator {
    static let mock = Navigator(
        screens: Screens(services: .mock),
        navigator: ScreenNavigator(window: UIWindow())
    )
}
