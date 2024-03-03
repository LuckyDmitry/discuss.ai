import SwiftUI

struct FlippedUpsideDownModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .rotationEffect(.radians(Double.pi))
      .scaleEffect(x: -1, y: 1, anchor: .center)
  }
}

extension View {
  func flippedUpsideDown() -> some View {
    modifier(FlippedUpsideDownModifier())
  }
}
