import SwiftUI

struct DebateHeaderView: View {
    var title: String
    var onCloseTap: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
              Button(action: onCloseTap, label: {
                Asset.Common.close.swiftUIImage
                    .resizable()
                    .frame(width: 24, height: 24)
              })
            }
            Text(title)
                .font(.sfPro(.semibold, size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
        }
        .padding(.horizontal, 20)
    }
}

struct DebateHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DebateHeaderView(
            title: "Planets · Round 1",
            onCloseTap: {}
        )
    }
}
