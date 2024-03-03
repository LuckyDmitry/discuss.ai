//
//  DictionaryProvider.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 25.05.2023.
//

import Foundation

final class ChatGPTDictionaryProvider: IDictionaryProvider {
  
  private let chatGPT: IChatGPTService
  
  init(chatGPT: IChatGPTService) {
    self.chatGPT = chatGPT
  }
  
  func requestExplanation(_ phrase: String) async throws -> String {
    ""
//    let response = try await chatGPT
//      .ask("Explain using simple languge what this phrase means - \(phrase). Be concise.")
//    guard let content = response.choices.first?.message.content else {
//      throw NetworkError.requestFailed
//    }
//    return content
  }
  
  func requestTranslation(_ phrase: String) async throws -> String {
    ""
//    let response = try await chatGPT
//      .ask("Translate this phrase into russian - \(phrase).")
//    guard let content = response.choices.first?.message.content else {
//      throw NetworkError.requestFailed
//    }
//    return content
  }
}
