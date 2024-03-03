import SwiftUI
import Lottie

struct PrimaryLoader: View {

  var body: some View {
    let cat = LottieAnimation.named("cat_lottie")
    LottieView(animation: cat)
      .playing(loopMode: .loop)
  }
}

struct PrimaryLoader_Previews: PreviewProvider {
    static var previews: some View {
      PrimaryLoader()
    }
}
