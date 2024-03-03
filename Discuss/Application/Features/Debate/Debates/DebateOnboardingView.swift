import SwiftUI

struct DebateOnboardingView: View {
    let debate: DebateQuestion
    let onCloseTap: () -> Void
    let onNextTap: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            DebateHeaderView(
                title: debate.title,
                onCloseTap: onCloseTap
            )
            Asset.image.swiftUIImage
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.top, 130)
            
            Text("Let's go")
                .font(.sfPro(.bold, size: 24))
                .padding(.top, 30)
            
            Text("The debate consists of 3 rounds. You have 3 minutes each. You need to give arguments. After the round, you will be able to analyze your answer")
                .font(.sfPro(.regular, size: 18))
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                .padding(.horizontal, 44)
            Spacer()
            PrimaryButton(
                action: onNextTap,
                text: "Next"
            )
            .padding(24)
        }
    }
}

struct DebateOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        DebateOnboardingView(
            debate: .random(),
            onCloseTap: {},
            onNextTap: {}
        )
    }
}
