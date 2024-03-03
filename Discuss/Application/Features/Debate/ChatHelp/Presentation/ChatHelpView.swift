//
//  ChatHelpView.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 02/12/2023.
//

import SwiftUI
import Lottie
import ActivityIndicatorView

struct ChatHelpView: View {
  
  @StateObject
  var viewContext: ViewContext<ChatHelpState, ChatHelpAction>
  
  var body: some View {
    let light = LottieAnimation.named("lighting_lottie")
    switch viewContext.state {
    case .idle, .error:
      LottieView(animation: light)
        .playbackMode(.paused(at: .frame(40)))
        .onTapGesture {
          viewContext.handle(.tapOnHelp)
        }
        .frame(width: 40, height: 40)
        .background {
          Circle()
            .stroke(lineWidth: 2)
            .stroke(Asset.Colors.Surfaces.Dark.mint.swiftUIColor)
        }
    case .loading:
      LottieView(animation: light)
        .playing(loopMode: .loop)
        .frame(width: 40, height: 40)
        .background {
          ActivityIndicatorView(
            isVisible: .constant(true),
            type: .arcs(count: 2, lineWidth: 2)
          )
          .foregroundColor(Asset.Colors.Surfaces.Dark.mint.swiftUIColor)
        }
    case let .content(context):
      ContentMessageView(
        isLeadingAlignment: false,
        isSuggest: true
      ) {
        VStack(alignment: .leading) {
          Text("Example of what you can say:")
            .font(.sfPro(.bold, size: 16))
          Text(context.suggest)
            .font(.sfPro(.regular, size: 14))
            .padding(.top, 2)
          Divider()
            .padding(.horizontal, 2)
          Text(context.translation)
            .font(.sfPro(.regular, size: 14))
            .padding(.top, 4)
        }
      }
    }
  }
}

#Preview {
  ChatHelpView(viewContext: .preview(.loading))
}
