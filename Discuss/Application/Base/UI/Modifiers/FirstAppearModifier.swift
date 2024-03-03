import SwiftUI

extension View {
  func onFirstAppear(perform action: (() -> Void)? = nil) -> some View {
    modifier(FirstAppearanceActionViewModifier(action: action))
  }
}

private struct FirstAppearanceActionViewModifier: ViewModifier {
  var action: (() -> Void)?
  
  @State
  private var shouldPerformAction = true
  
  func body(content: Content) -> some View {
    content
      .onAppear {
        guard shouldPerformAction else {
          return
        }
        
        shouldPerformAction = false
        action?()
      }
  }
}
