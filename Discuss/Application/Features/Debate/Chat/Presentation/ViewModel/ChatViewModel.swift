import Foundation
import Combine
import SwiftUI

struct ChatIntermediateMessage {
  var message: String
  var isUser: Bool
}

@MainActor
final class ChatViewModel: BaseViewModel {
  typealias State = ChatState
  typealias Action = ChatAction
  
  private(set) var state: CurrentValueSubject<ChatState, Never>
  
  private(set) var alertMessage: String?
  
  private var startDateRecording: Date?
  
  private var cancellables = Set<AnyCancellable>()
  
  private let chatRouter: ChatRouter
  private let chatUseCase: IChatUseCase
  
  private var currentRound: Int {
    value.chatViewBlocks.count / 2
  }
  
  private var isLastMessage: Bool {
    self.state.value.chatViewBlocks.filter { $0.alignment == .bot }.count == value.totalRounds - 1
  }
  
  init(
    chatRouter: ChatRouter,
    chatUseCase: IChatUseCase,
    totalRounds: Int,
    debateQuestion: String
  ) {
    self.chatUseCase = chatUseCase
    self.chatRouter = chatRouter
    self.state = .init(ChatState(debateTitle: debateQuestion, totalRounds: totalRounds))
  }

  func handle(_ action: Action) {
    Task {
      switch action {
      case .tapCancelRecording:
        await cancelRecording()
      case .tapExitLesson:
        AnalyticsService.event(.tapOnCloseChat(
          userMessages: value.chatViewBlocks.filter { $0.alignment == .user }.count,
          botMessages: value.chatViewBlocks.filter { $0.alignment == .bot }.count
        ))
        chatRouter.onExitLesson()
      case .tapStartRecording:
        await startRecording()
      case .tapStopRecording:
        await stopRecording()
      case .viewAppeared:
        await viewAppeared()
      case .tapOnHelp:
        break
      case .viewDissappeared:
        break
      }
    }
  }

  private func cancelRecording() async {
    _ = try? await chatUseCase.cancelRecording()
    modify {
      $0.isRecording = false
    }
    AnalyticsService.event(.tapOnCancelRecording)
  }
  
  private func startRecording() async {
    do {
      
      try await chatUseCase.startRecording { _ in }
      modify {
        $0.isRecording = true
      }
    } catch {
      print("ERROR")
    }
  }
  
  private func stopRecording() async {
    do {
      modify {
        $0.isRecording = false
        $0.isInputHidden = true
        $0.chatViewBlocks.replaceLast(alignment: .user, content: .loading)
      }
      let userRecognizedSpeech = try await chatUseCase.stopRecording()
      AnalyticsService.event(.tapOnStopRecording(words: userRecognizedSpeech.split().count))
      
      modify {
        $0.chatViewBlocks.replaceLast(alignment: .user, content: .plain(userRecognizedSpeech))
        $0.isInputHidden = false
        $0.currentRound += 1
      }
      chatUseCase.playSuccess()
      await handlePreviousResponse()
    } catch {
      print("ERROR")
    }
  }
  
  private func viewAppeared() async {
    AnalyticsService.screenAppear(.chat)
    await handleUserMessage("")
  }
  
  private func handlePreviousResponse() async {
    guard let viewBlock = value.chatViewBlocks.last,
          let message = viewBlock.content.text else {
      // TODO: Invalid state
      return
    }
    await handleUserMessage(message)
  }
  
  private func handleUserMessage(_ message: String) async {
    do {
      let isStart = value.chatViewBlocks.isEmpty
      modify {
        $0.chatViewBlocks.append(alignment: .bot, content: .loading)
        $0.isInputHidden = true
      }

      let botResponseMessage: String
      if isStart {
        botResponseMessage = try await chatUseCase.start()
      } else {
        botResponseMessage = try await chatUseCase.sendMessage(message)
      }
      modify {
        $0.chatViewBlocks.replaceLast(alignment: .bot, content: .plain(botResponseMessage))
        $0.isInputHidden = false
        if !self.isLastMessage {
          $0.chatViewBlocks.append(alignment: .user, content: .help)
        }
      }
    } catch {
      print("ERROR")
    }
  }

  private func finishDialog() {
    let chatResults: [ChatIntermediateMessage] = self.state.value.chatViewBlocks.compactMap {
      switch $0.content {
      case let .plain(message):
        return ChatIntermediateMessage(message: message, isUser: !$0.alignment.isBot)
      default:
        return nil
      }
    }
    chatRouter.onLessonFinished(messages: chatResults)
  }
}

private extension Array where Element == ChatViewBlock {
  
  mutating func append(alignment: ChatViewBlock.BlockAlignment, message: String) {
    self.append(ChatViewBlock(alignment: alignment, message: message))
  }
  
  mutating func append(alignment: ChatViewBlock.BlockAlignment, content: ChatViewBlock.MessageContent) {
    self.append(ChatViewBlock(alignment: alignment, content: content))
  }
  
  mutating func replaceLast(alignment: ChatViewBlock.BlockAlignment, content: ChatViewBlock.MessageContent) {
    let lastIndex = self.endIndex - 1
    guard lastIndex < self.count else {
      assertionFailure()
      return
    }
    self[lastIndex] = .init(alignment: alignment, content: content)
  }

  func toIntermediateMessage() -> [ChatIntermediateMessage] {
    self.compactMap {
      guard let text = $0.content.text else {
        return nil
      }
      return ChatIntermediateMessage(message: text, isUser: !$0.alignment.isBot)
    }
  }
}
