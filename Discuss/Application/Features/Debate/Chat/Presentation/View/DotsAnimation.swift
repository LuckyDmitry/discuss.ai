import SwiftUI

struct DotsAnimation: View {
  @State private var scale1: CGFloat = 1.0
  @State private var scale2: CGFloat = 1.0
  @State private var scale3: CGFloat = 1.0
  
  var body: some View {
    HStack(spacing: 16) {
      Circle()
        .foregroundColor(.white)
        .scaleEffect(scale1)
      Circle()
        .foregroundColor(.white)
        .scaleEffect(scale2)
      Circle()
        .foregroundColor(.white)
        .scaleEffect(scale3)
    }
    .onAppear {
      withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
        scale1 = 1.3
      }
      withAnimation(Animation.easeInOut(duration: 0.66).delay(0.33).repeatForever()) {
        scale2 = 1.3
      }
      withAnimation(Animation.easeInOut(duration: 0.33).delay(0.66).repeatForever()) {
        scale3 = 1.3
      }
    }
  }
}
