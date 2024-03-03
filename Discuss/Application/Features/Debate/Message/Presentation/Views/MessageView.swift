//
//  MessageView.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 01/12/2023.
//

import SwiftUI
import ActivityIndicatorView

struct MessageView: View {
  
  @StateObject
  var viewContext: ViewContext<MessageViewState, MessageViewAction>
  
  init(isBotMessage: Bool, message: String) {
    self._viewContext = StateObject(wrappedValue: ViewContext(viewModel: MessageViewModel(
      isBotMessage: isBotMessage,
      message: message
    )))
  }
  
  var body: some View  {
    ContentMessageView(isLeadingAlignment: viewContext.isBotMessage) {
      VStack(alignment: .leading) {
        originalMessageView
        if viewContext.isBotMessage {
          botFeedBackView
        } else {
          userFeedBackView
            .animation(.easeInOut, value: viewContext.feedBackState.content?.isImprovmentsShown)
        }
      }
      .frame(maxWidth: .infinity, alignment: viewContext.isBotMessage ? .leading : .trailing)
    }
    .onFirstAppear {
      viewContext.handle(.messageAppeared)
    }
  }
  
  private var originalMessageView: some View {
    VStack(alignment: .leading) {
      Text(viewContext.translationState.content?.translation ?? viewContext.message)
        .foregroundColor(viewContext.isBotMessage ? .black : .white)
        .font(.sfPro(.regular, size: 18))
        .fixedSize(horizontal: false, vertical: true)
    }
  }
  
  private var userFeedBackView: some View {
    VStack(alignment: .trailing) {
      Rectangle()
        .frame(height: 1)
        .foregroundStyle(.white)
        .opacity(0.3)
      HStack {
        switch viewContext.feedBackState {
        case .idle, .error:
          EmptyView()
        case .loading:
          ActivityIndicatorView(
            isVisible: .constant(true),
            type: .growingArc(.white, lineWidth: 1.7)
          )
          .frame(width: 20, height: 20)
          .transition(.scale)
        case let .content(feedBackMessage):
          VStack(alignment: .leading) {
            HStack {
              Text(feedBackMessage.areThereMistakes ? "Needs work" : "Excellent")
                .font(.sfPro(.bold, size: 16))
                .foregroundStyle(.yellow)
              Spacer()
              Asset.Common.chevronDown.swiftUIImage
                .renderingMode(.template)
                .foregroundStyle(.white)
                .rotationEffect(.degrees(feedBackMessage.isImprovmentsShown ? 180 : 0))
            }
            .contentShape(Rectangle())
            .onTapGesture {
              viewContext.handle(.tapOnImprovments)
            }
            if feedBackMessage.isImprovmentsShown {
              VStack(alignment: .leading) {
                Text(getAttributedString(feedBackMessage.improvments))
                  .foregroundColor(.white)
                  .font(.sfPro(.regular, size: 16))
                  .fixedSize(horizontal: false, vertical: true)
              }
            }
          }
          .onTapGesture {
            viewContext.handle(.tapOnImprovments)
          }
        }
      }
    }
  }
  
  private var botFeedBackView: some View {
    HStack {
      Button(action: {
        viewContext.handle(.tapOnTranslatingMessage)
      }, label: {
        switch viewContext.translationState {
        case .idle, .error, .content:
          Asset.Chat.messageTranslate.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        case .loading:
          ProgressView()
            .frame(width: 24, height: 24)
        }
      })
      .frame(width: 24, height: 24)
      Button(action: {
        viewContext.handle(.tapOnPlayingMessage)
      }, label: {
        if viewContext.isPlaying {
          Asset.Chat.pause.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        } else {
          Asset.Chat.messageRetry.swiftUIImage
            .resizable()
            .frame(width: 24, height: 24)
        }
      })
    }
  }
  
  func getAttributedString(_ message: String) -> AttributedString {
    var attributedString = AttributedString(message)
    
    attributedString.foregroundColor = .white
    attributedString.font = .sfPro(.regular, size: 16)
    
    if let improvedRange = attributedString.range(of: "Improved version:") {
      attributedString[improvedRange].foregroundColor = .yellow
      attributedString[improvedRange].font = .sfPro(.bold, size: 16)
    }
    
    if let grammarRange = attributedString.range(of: "Grammar:") {
      attributedString[grammarRange].foregroundColor = .yellow
      attributedString[grammarRange].font = .sfPro(.bold, size: 16)
    }
    
    if let vocabularyRange = attributedString.range(of: "Vocabulary:") {
      attributedString[vocabularyRange].foregroundColor = .yellow
      attributedString[vocabularyRange].font = .sfPro(.bold, size: 16)
    }
    
    return attributedString
  }
}

#Preview {
  MessageView(viewContext: .preview(MessageViewState(
    isBotMessage: false,
    message: "Asdsa",
    feedBackState: .content(.init(isImprovmentsShown: true, improvments: "Improved version: 'here insert improvements'.\nGrammar: 'here grammar'.\nVocabulary: 'here vocabulary'.", areThereMistakes: true))
  )))
}

private extension MessageView {
  init(viewContext: ViewContext<MessageViewState, MessageViewAction>) {
    self._viewContext = StateObject(wrappedValue: viewContext)
  }
}
