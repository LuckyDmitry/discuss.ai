import ActivityIndicatorView
import SwiftUI

struct ProfileSettingsView: View {  
  @StateObject
  var viewContext: ViewContext<ProfileSettingsState, ProfileSettingsAction>
  
  @State
  private var languageViewHeight: CGFloat = .zero
  
  @State
  private var chooseLanguageLevelViewShown: LanguageLevel?
  
  @State
  private var chooseNativeLanguageViewShown = false
  
  @State
  private var chooseTargetLanguageViewShown = false
  
  @State
  private var notificationTimeEnabled = false
  
  @State
  private var chooseNotificationTimeViewShown = false
  
  var body: some View {
    VStack {
      VStack(alignment: .leading) {
        HStack {
          Button(action: {
            viewContext.handle(.tapBack)
          }, label: {
            Asset.Common.backChevron.swiftUIImage
          })
          .padding(.trailing, 40)
          Text("Settings")
            .font(.sfPro(.bold, size: 24))
        }
        if let userInfo = viewContext.userInfo {
          ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
              myEnglishLevelSectionView(userInfo: userInfo)
                .padding(.top, 42)
              
              languagesViewSection(userInfo: userInfo)
                .padding(.top, 36)
              
//              notificationsViewSection(userInfo: userInfo)
//                .padding(.top, 36)
              
              feedbackSectionView(userInfo: userInfo)
                .padding(.top, 36)
              Button(action: {
                viewContext.handle(.tapLogout)
              }, label: {
                PrimaryText("Log out")
                  .font(.sfPro(.medium, size: 20))
                  .frame(maxWidth: .infinity)
              })
              .frame(height: 48)
              .background(RoundedRectangle(cornerRadius: 24)
                .fill( Asset.Colors.Surfaces.gray2.swiftUIColor))
              .padding(.top, 32)
              Spacer()
            }
          }
        } else {
          ActivityIndicatorView(isVisible: .constant(true), type: .opacityDots(count: 3, inset: 3))
            .foregroundColor(Colors.TextAndIcons.gray1.color)
            .frame(width: 50, height: 25)
        }
      }
    }
    .disabled(!viewContext.userTouchEnabled)
    .onAppear {
      viewContext.handle(.viewAppeared)
    }
    .sheet(item: $chooseLanguageLevelViewShown) { languageLevel in
      ProfileSettingsChooseLevelView(
          chosen: languageLevel,
          onFinish: {
            chooseLanguageLevelViewShown = nil
            viewContext.handle(.languageLevelUpdate($0))
          }
      )
      .presentationDetents([.fraction(0.7)])
      .presentationDragIndicator(.visible)
    }
    .sheet(isPresented: $chooseTargetLanguageViewShown) {
      ProfileSettingsChooseLanguageView(
        items: Language.allCases.filter { $0 != (viewContext.userInfo?.nativeLanguage ?? .ru) },
        chosen: viewContext.userInfo?.learningLanguage ?? .en,
        onFinish: {
          chooseTargetLanguageViewShown = false
          viewContext.handle(.targetLanguageUpdate($0))
        },
        isTarget: true
      )
    }
    .padding(.horizontal, 20)
  }
  
    private func notificationsViewSection(userInfo: UserProfileInfo) -> some View {
      EmptyView()
//      VStack(alignment: .leading, spacing: 0) {
//        HStack {
//          PrimaryText("Notifications")
//            .font(.sfPro(.bold, size: 20))
//          Spacer()
//          Toggle("", isOn: $notificationTimeEnabled)
//            .tint(Colors.Surface.blue.color)
//            .padding(.trailing, 3)
//        }
//        .padding(.bottom, 20)
//
//        SecondaryButton(
//          title: "\(userInfo.notificationTime ?? 20):00",
//          subtitle: "Time for reminders",
//          isPressed: !chooseNotificationTimeViewShown,
//          action: {
//            chooseNotificationTimeViewShown = true
//          },
//          chevronNeeded: true
//        )
//        .disabled(!notificationTimeEnabled)
//      }
    }
    
    private func myEnglishLevelSectionView(userInfo: UserProfileInfo) -> some View {
      VStack(alignment: .leading, spacing: 0) {
        PrimaryText("My english level")
          .font(.sfPro(.bold, size: 20))
          .padding(.bottom, 20)
        
        SecondaryButton(
          title: userInfo.languageLevel.onboardingItem.title,
          action: {
            chooseLanguageLevelViewShown = userInfo.languageLevel
          },
          leadingImage: userInfo.languageLevel.onboardingItem.image,
          chevronNeeded: true
        )
      }
    }

  private func languagesViewSection(userInfo: UserProfileInfo) -> some View {
    VStack(alignment: .leading, spacing: 0) {
      PrimaryText("Languages")
        .font(.sfPro(.bold, size: 20))
        .padding(.bottom, 20)

      SecondaryButton(
        title: userInfo.nativeLanguage.title,
        subtitle: "Native",
        action: {
          chooseNativeLanguageViewShown = true
        },
        chevronNeeded: false
      )
      .disabled(true)
      .padding(.bottom, 12)

      SecondaryButton(
        title: userInfo.learningLanguage.title,
        subtitle: "Learning",
        action: {
            chooseTargetLanguageViewShown = true
        },
        chevronNeeded: true
      )
    }
  }

  private func feedbackSectionView(userInfo: UserProfileInfo) -> some View {
    VStack(alignment: .leading, spacing: 0) {
      PrimaryText("Feedback")
        .font(.sfPro(.bold, size: 20))
        .padding(.bottom, 20)
      
      SecondaryButton(
        title: "Contact us",
        action: {
          
        },
        leadingImage: Asset.Profile.world.swiftUIImage,
        chevronNeeded: true
      )
      .padding(.bottom, 12)
      
      SecondaryButton(
        title: "Rate the app",
        action: {
          
        },
        leadingImage: Asset.Profile.star.swiftUIImage,
        chevronNeeded: true
      )
    }
  }
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
      ProfileSettingsView(viewContext: .preview(ProfileSettingsState(
        userInfo: .placeholder
      )))
    }
}

extension Optional where Wrapped == String {
  var redacted: String {
    switch self {
    case .none:
      return "somecontent"
    case .some(let wrapped):
      return wrapped
    }
  }
}
