//
//  MessageView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 25.03.2023.
//

import SwiftUI
import ActivityIndicatorView

struct ChatViewBlockContainer : View {
  var chatViewBlock: ChatViewBlock
  var onHelpTap: () -> Void
  
  var body: some View {
    VStack {
      HStack {
        switch chatViewBlock.content {
        case .help:
          ChatHelpView(viewContext: .init(viewModel: ChatHelpViewModel()))
            .padding(.init(top: 0, leading: 75, bottom: 30, trailing: 10))
        case .plain(let message):
          MessageView(isBotMessage: chatViewBlock.alignment.isBot, message: message)
            .padding(chatViewBlock.alignment.paddings)
        case .loading:
          loadingView
            .padding(chatViewBlock.alignment.paddings)
        case let .error(errorMessage):
          ContentMessageView(isLeadingAlignment: chatViewBlock.alignment.isBot) {
            
          }
        case let .roundDivider(round: roundNumber):
          roundEvaluator
            .padding(chatViewBlock.alignment.paddings)
        }
      }
      .frame(
        maxWidth: .infinity,
        alignment: chatViewBlock.alignment.alignment
      )
    }
  }
  
  @ViewBuilder
  private var roundEvaluator: some View {
    HStack {
      Rectangle()
        .frame(height: 1)
      Text("Round \(2)")
        .font(.sfPro(.thin, size: 12))
      Rectangle()
        .frame(height: 1)
    }
    .foregroundColor(.white)
  }
  
  private var loadingView: some View {
    ContentMessageView(
      isLeadingAlignment: chatViewBlock.alignment.isBot) {
        ActivityIndicatorView(isVisible: .constant(true), type: .opacityDots(count: 3, inset: 3))
          .foregroundColor(Colors.TextAndIcons.gray1.color)
          .frame(maxWidth: 50, idealHeight: 30)
      }
  }
}

struct ChatViewBlockContainer_Preview: PreviewProvider {
  static var previews: some View {
    ChatViewBlockContainer(
      chatViewBlock: .init(alignment: .user, content: .help),
      onHelpTap: { }
      
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

private extension ChatViewBlock.BlockAlignment {
  var paddings: EdgeInsets {
    switch self {
    case .center:
      return .init(top: 50, leading: 20, bottom: 50, trailing: 20)
    case .bot:
      return .init(top: 0, leading: 20, bottom: 30, trailing: 75)
    case .user:
      return .init(top: 0, leading: 75, bottom: 30, trailing: 20)
    }
  }
  
  var alignment: Alignment {
    switch self {
    case .center:
      return .center
    case .bot:
      return .leading
    case .user:
      return .trailing
    }
  }
}
