//
//  MockChatProvider.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 30.05.2023.
//

import Foundation

//final class MockChatProvider: IChatProvider {
//  func improveMessage(_ message: Message, improvmentsType: MessageImprovmentsType) async throws -> MessageImprovment {
//    return try await Task {
//      try await Task.sleep(for: .seconds(2))
//      return MessageImprovment(content: "Improved message")
//    }.value
//  }
//  
//  func setupService(promt: String) async throws -> ChatResponse {
//    return response
//  }
//  
//  func sendAssistantMessage(_ message: Message) async throws -> ChatResponse {
//    return response
//  }
//  
//  var response: ChatResponse = .init(message: "Response")
//  
//  func sendUserMessage(_ message: Message) async throws -> ChatResponse {
//    return response
//  }
//}

struct MockChatGPTService: IChatGPTService {
  func askWithHistory(_ messagesHistory: [ChatGPTDTO.Message]) async throws -> String {
    return "new message"
  }
  
  var delay: Int = 0
  var response: String? = nil
  
  func ask(_ message: String) async throws -> String {
    try await Task {
      try await Task.sleep(for: .seconds(delay))
      return response ?? "Example response"
    }.value
  }
  
  func askWithHistory(_ messagesHistory: ChatGPTDTO.Input) async throws -> String {
    try await Task {
      try await Task.sleep(for: .seconds(delay))
      return response ?? "Example response"
    }.value
  }
  
  func ask<Object>(_ message: String) async throws -> Object where Object : Decodable {
    fatalError()
  }
}

final class MockVoiceRecorder: IVoiceRecorder {
  var isRecording: Bool = false
  func startRecording() throws {
    
  }
  
  func stopRecording() throws -> URL {
    return URL(string: "www.yandex.ru")!
  }
}

final class MockSpeechRecognizer: ISpeechRecognizer {
  func startRecording(_ intermediateResults: ((String) -> Void)?) throws {
    var result = ""
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(30)) {
      result += "Hello"
      intermediateResults?(result)
      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(30)) {
        result += "dear"
        intermediateResults?(result)
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(30)) {
          result += "teacher"
          intermediateResults?(result)
          DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(30)) {
            result += "wonderful."
            intermediateResults?(result)
          }
        }
      }
    }
  }
  
  func setupLanguage(_ language: Language) {
    
  }
  
  func stop() async throws -> String {
    return "Hello dear teacher wonderful."
  }
}

final class MockSpeechSynthesizer: ISpeechSynthesizer {
  func textToSpeech(_ text: String) async throws -> Data {
    Data()
  }
}

final class MockAuthService: IAuthService {
  var userUid: String? {
    ""
  }
  
  func signInWithGoogle() async throws {
    
  }
  
  func signOut() async throws {
    
  }
}
