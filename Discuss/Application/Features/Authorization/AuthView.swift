import SwiftUI
import Nivelir

struct AuthView: View {
  @ObservedObject
  private var model: AuthViewModel
  
  init(authViewModel: AuthViewModel) {
    model = authViewModel
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Rectangle()
        .fill(Gradient(colors: Colors.Gradient.blue.colors))
        .frame(width: 43, height: 43)
        .padding(.top, 112)
      PrimaryText("Discuss")
        .sfPro(.bold, size: 32)
        .padding(.top, 24)
      PrimaryText("Get started on your AI-bot practice journey by signing in!")
        .sfPro(.medium, size: 20)
        .padding(.top, 16)
      Button(action: {
        AnalyticsService.event(.tapOnLogin)
        model.googleSignInPressed()
      }, label: {
        HStack {
          Asset.Auth.googleLogo.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
          Spacer()
          PrimaryText("Sign in with Google")
            .sfPro(.medium, size: 20)
          Spacer()
        }
          .frame(maxWidth: .infinity)
          .padding(.horizontal, 16)
          .padding(.vertical, 14)
          .background(RoundedRectangle(cornerRadius: 24)
            .stroke(.gray.opacity(0.4)))
          
      })
      .padding(.top, 40)
      Spacer()
    }
    .onAppear {
      AnalyticsService.screenAppear(.login)
    }
    .padding(.horizontal, 24)
  }
}


#if DEBUG
struct AuthView_Previews: PreviewProvider {
  static var previews: some View {
    AuthView(authViewModel: .init(
      services: Services.mock,
      screenNavigator: ScreenNavigator(window: UIWindow()),
      screens: Screens(services: .mock))
    )
  }
}
#endif
