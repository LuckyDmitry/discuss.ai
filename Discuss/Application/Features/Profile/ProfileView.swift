import SwiftUI
import ActivityIndicatorView
import Combine

struct ProfileState: Equatable {
  struct UserInfo: Equatable {
    enum WeekdayStreak: Equatable {
      case missed
      case completed
      case clear
    }
    
    var name: String
    var points: Int
    var longestStreak: Int
    var wordsSpoken: Int
    var sentencesSpoken: Int
    var weekdaysStreak: [WeekdayStreak]
  }
  
  var userInfo: UserInfo?
}

enum ProfileAction {
  case viewAppeared
  case settingsTap
}

struct ProfileView: View {
  
  @StateObject
  var viewContext: ViewContext<ProfileState, ProfileAction>
  
  @State
  private var isAnimating = false
  
  var body: some View {
    VStack {
      if let userInfo = viewContext.userInfo {
        content(userInfo)
      } else {
        ActivityIndicatorView(isVisible: .constant(true), type: .opacityDots(count: 3, inset: 3))
          .foregroundColor(Colors.TextAndIcons.gray1.color)
          .frame(width: 50, height: 25)
      }
    }
    .onAppear {
      viewContext.handle(.viewAppeared)
    }
    .onReceive(viewContext.$state) { state in
      withAnimation {
        isAnimating = state.userInfo != nil
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 8)
    .background()
  }
  
  @ViewBuilder
  private func content(_ userInfo: ProfileState.UserInfo) -> some View {
    VStack(alignment: .leading, spacing: 24) {
      HStack {
        Text("Profile")
          .font(.sfPro(.bold, size: 24))
        Spacer()
        Button(action: {
          viewContext.handle(.settingsTap)
        }, label: {
          Asset.Profile.settings.swiftUIImage
        })
      }
      .transition(.opacity.animation(.easeIn(duration: 1.0)))
      
      ScrollView(showsIndicators: false) {
        userCard(userInfo: userInfo)
          .smoothAppear(isAnimating: isAnimating, delay: 0.05)
          .padding(.vertical, 24)
//        daysOnStreakCard(daysStreak: userInfo.weekdaysStreak)
//          .padding(.vertical, 24)
//          .smoothAppear(isAnimating: isAnimating, delay: 0.10)
        VStack(spacing: 16) {
          achievmentsCard(
            title: "\(userInfo.longestStreak) days",
            subtitle: "Longest streak",
            image: Asset.Profile.fire.swiftUIImage
          )
          .smoothAppear(isAnimating: isAnimating, delay: 0.15)
          .padding(.top, 16)
          
          achievmentsCard(
            title: "\(userInfo.sentencesSpoken)",
            subtitle: "Sentences spoken",
            image: Asset.Profile.world.swiftUIImage
          )
          .smoothAppear(isAnimating: isAnimating, delay: 0.20)
          
          achievmentsCard(
            title: "\(userInfo.wordsSpoken)",
            subtitle: "Unique words spoken",
            image: Asset.Profile.book.swiftUIImage
          )
          .smoothAppear(isAnimating: isAnimating, delay: 0.25)
          
          achievmentsCard(
            title: "5",
            subtitle: "Stars conquered",
            image: Asset.Profile.star.swiftUIImage
          )
          .smoothAppear(isAnimating: isAnimating, delay: 0.30)
        }
      }
    }
    .animation(.default, value: isAnimating)
  }
  
  private func userCard(userInfo: ProfileState.UserInfo) -> some View {
    VStack(alignment: .leading) {
      HStack {
        Text("\(userInfo.name.firstCapitalized.first?.description ?? "")")
          .font(.sfPro(.semibold, size: 14))
          .foregroundColor(Asset.Colors.TxtIcons.Light.accent.swiftUIColor)
          .padding(15)
          .background(
            Circle()
              .fill(Asset.Colors.Surfaces.Light.lightBlue.swiftUIColor)
          )
        VStack(alignment: .leading) {
          Text(userInfo.name)
            .foregroundColor(.black)
            .font(.sfPro(.bold, size: 16))
          Text("Diamond league")
            .font(.sfPro(.regular, size: 14))
            .foregroundColor(Asset.Colors.TxtIcons.Light.gray2.swiftUIColor)
        }
        Spacer()
        Text("\(userInfo.points) points")
          .font(.sfPro(.medium, size: 16))
          .foregroundColor(.black)
      }
    }
    .padding(.horizontal, 18)
    .padding(.vertical, 16)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      RoundedRectangle(cornerRadius: 20)
        .fill(Asset.Colors.Surfaces.Light.gray3.swiftUIColor)
    )
  }
  
  private func daysOnStreakCard(daysStreak: [ProfileState.UserInfo.WeekdayStreak]) -> some View {
    VStack(spacing: 0) {
      let weekdays = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
      HStack {
        Asset.Profile.fire.swiftUIImage
          .resizable()
          .frame(width: 24, height: 24)
        Text("Your week")
          .font(.sfPro(.medium, size: 16))
          .foregroundColor(.white)
      }
      .padding(.top, 18)
      .padding(.bottom, 22)
      HStack {
        ForEach(zip(weekdays, daysStreak).map { $0 }, id: \.0) { element in
          let weekdayName = element.0
          let status = element.1
          VStack(spacing: 10) {
            
            Circle()
              .stroke(lineWidth: 2)
              .foregroundColor(.white)
              .background(content: {
                switch status {
                case .clear:
                  Circle()
                    .fill(.clear)
                case .completed:
                  Circle()
                    .fill(.white)
                    .overlay {
                      Asset.Common.chevron.swiftUIImage
                        .resizable()
                        .padding(8)
                    }
                case .missed:
                  Circle()
                    .fill(.white)
                    .overlay {
                      Asset.Profile.missed.swiftUIImage
                        .resizable()
                        .padding(8)
                    }
                }
              })
              .padding(6)
            Text(weekdayName)
              .font(.sfPro(.semibold, size: 14))
              .foregroundColor(.white)
          }
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 8)
      .padding(.bottom, 12)
      
    }
    .padding(.horizontal, 18)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      RoundedRectangle(cornerRadius: 20)
        .fill(Asset.Colors.Surfaces.lightBlue.swiftUIColor)
    )
  }
  
  @ViewBuilder
  private func achievmentsCard(
    title: String,
    subtitle: String,
    image: Image
  ) -> some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {
        image
          .resizable()
          .frame(width: 22, height: 22)
        VStack(alignment: .leading) {
          Text(title)
            .font(.sfPro(.bold, size: 16))
          Text(subtitle)
            .font(.sfPro(.regular, size: 14))
            .foregroundColor(Asset.Colors.TxtIcons.Light.gray2.swiftUIColor)
        }
        Spacer()
      }
    }
    .padding(.horizontal, 18)
    .padding(.vertical, 16)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      RoundedRectangle(cornerRadius: 20)
        .fill(Asset.Colors.Surfaces.Light.gray3.swiftUIColor)
    )
  }
}

struct ProfileView_Previews: PreviewProvider {
  
  final class ProfileViewModelPreview: BaseViewModel {
    typealias State = ProfileState
    typealias Action = ProfileAction
    
    var state: CurrentValueSubject<ProfileState, Never> = .init(ProfileState())
    
    func handle(_ action: ProfileAction) {
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
        self.modify {
          $0.userInfo = .init(name: "Dmitrii", points: 12, longestStreak: 12, wordsSpoken: 12, sentencesSpoken: 12, weekdaysStreak: [
            .completed,
            .missed,
            .completed,
            .missed,
            .completed,
            .clear,
            .clear
          ])
        }
      }
    }
  }
  
  static var previews: some View {
    ProfileView(viewContext: .init(viewModel: ProfileViewModelPreview()))
  }
}

private extension View {
  func smoothAppear(isAnimating: Bool, delay: CGFloat) -> some View {
    self
      .animation(.easeIn(duration: 0.3).delay(delay), value: isAnimating)
      .opacity(isAnimating ? 1 : 0)
      .offset(y: isAnimating ? 0 : 20)
  }
}
