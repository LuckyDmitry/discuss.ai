import SwiftUI

struct ChangePreferenceViewView<ContentType: Titleble & Identifiable & Equatable>: View {
    let title: String
    let subtitle: String
    let preferences: [ContentType]
    let onChoosePreference: (ContentType) -> Void
    
    @State
    var currentPreference: ContentType
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .font(.sfPro(.bold, size: 20))
                        .padding(.top, 32)
                    Text(subtitle)
                        .font(.sfPro(.regular, size: 14))
                        .foregroundColor(Asset.Colors.TxtIcons.Light.gray2.swiftUIColor)
                        .padding(.top, 4)
                        .padding(.bottom, 28)
                    VStack(spacing: 16) {
                        ForEach(preferences) { preference in
                            SecondaryButton(
                                title: "\(preference.title)",
                                isPressed: preference == currentPreference,
                                action: {
                                    currentPreference = preference
                                }
                            )
                        }
                    }
                    Spacer()
                }
                .padding(.bottom, 100)
            }
            
            PrimaryButton(action: {
                onChoosePreference(currentPreference)
            }, text: "Choose")
            .padding(.top, 40)
            .padding(.bottom, 24)
        }
        .padding(.horizontal, 20)
    }
}

struct ChangePreferenceViewView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguageLevelView(
            currentLanguageLevel: .beginner,
            onChooseLanguageLevel: { _ in }
        )
    }
}

