#if canImport(UIKit)
import UIKit
import Nivelir

public struct HideTabBarDecarator<Container: UIViewController>: ScreenDecorator {
  
  public var payload: Any? {
    nil
  }
  
  public var description: String {
    "HideTabBarDecarator"
  }

  
  public func build<Wrapped: Screen>(
    screen: Wrapped,
    navigator: ScreenNavigator
  ) -> Container where Wrapped.Container == Container {
    let container = screen.build(navigator: navigator)
    container.hidesBottomBarWhenPushed = true
    
    return container
  }
}

extension Screen where Container: UIViewController {

  public func withHiddenTabBar() -> AnyScreen<Container> {
    decorated(by: HideTabBarDecarator())
  }
}
#endif
