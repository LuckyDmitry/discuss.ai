import Combine
import Foundation

struct ChatUseMessage {
  var isCommand: Bool
  var message: ChatGPTDTO.Message
}

struct ChatEvaluation: Decodable {
  var score: Int
}

final class ChatUseCase: IChatUseCase {
  var isPlayingMessageFinished: AnyPublisher<Void, Never> {
    services.playingListener.playingItemFinished.map { _ in }.eraseToAnyPublisher()
  }

  typealias Services =
  HasChatGPTService &
  HasVoicePlayer &
  HasVoiceRecorder &
  HasSpeechRecognizer &
  HasSpeechSynthesizer &
  HasTranslationService &
  HasProfileService &
  HasMessageEvaluatorService &
  HasPlayingListener &
  HasChatMessageHistoryService
  
  private let services: Services
  private var messageHistory: [ChatUseMessage] = []

  private var interceptor: ChatDebateInterceptor
  private let evaluatorInterceptor: ChatEvaluatorInterceptor
  
  init(
    services: Services,
    interceptor: ChatDebateInterceptor,
    evaluatorInterceptor: ChatEvaluatorInterceptor
  ) {
    self.services = services
    self.interceptor = interceptor
    self.evaluatorInterceptor = evaluatorInterceptor
  }

  deinit {
    services.voicePlayer.stop()
  }
  
  func playSuccess() {
    guard let url = Bundle.main.url(forResource: "success_sound", withExtension: "mp3") else { return }
    try? services.voicePlayer.playSimultaneouslyIfNeeded(url: url)
  }
  
  func requestCurrentRating() async throws -> Int {
    let messages = evaluatorInterceptor.intercept(messageHistory)
    let evaluation: ChatEvaluation = try await services.chatGPTService.ask(messages.first?.message.content ?? "")
    return evaluation.score
  }
  
  func startRecording(_ onPartialResuts: @escaping (String) -> Void) async throws {
    services.playingListener.startRecording()
    try services.speechRecognizer.startRecording(onPartialResuts)
  }
  
  func stopRecording() async throws -> String {
    try await Task {
      try await Task.sleep(for: .milliseconds(550))
      return try await services.speechRecognizer.stop()
    }.value
  }
  
  func cancelRecording() async throws {
    _ = try await services.speechRecognizer.stop()
  }
  
  func sendMessage(_ message: String) async throws -> String {
    messageHistory.append(.init(isCommand: false, message: .init(content: message, role: .user)))
    services.chatMessageHistoryService.add(.init(content: message, role: .user))
    return try await sendMessageHistory()
  }
  
  func start() async throws -> String {
    let profile = try? await services.profileService.getUserInfo()
    interceptor.setupLanguage(profile?.learningLanguage ?? .en)
    services.speechRecognizer.setupLanguage(profile?.learningLanguage ?? .en)
    return try await sendMessageHistory()
  }
  
  func exit() async throws {
    services.voicePlayer.stop()
    _ = try await services.speechRecognizer.stop()
  }
  
  private func sendMessageHistory() async throws -> String {
    messageHistory = interceptor.intercept(messageHistory)
    let messages: [ChatGPTDTO.Message] = messageHistory.map { .init(
      content: $0.message.content,
      role: $0.isCommand ? .user : ($0.message.role)
    ) }
    let response = try await services.chatGPTService.askWithHistory(messages)
    services.chatMessageHistoryService.add(.init(content: response, role: .assistant))
    messageHistory.append(.init(isCommand: false, message: .init(content: response, role: .assistant)))
    return response
  }
}
