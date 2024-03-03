import Foundation
import SwiftUI
import Nivelir

final class UIHostingKeyedViewController<RootView: View>: UIHostingController<RootView>, ScreenKeyedContainer {
  
  var screenKey: ScreenKey
  
  init(rootView: RootView, screenKey: ScreenKey) {
    self.screenKey = screenKey
    super.init(rootView: rootView)
  }
  
  @MainActor required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
