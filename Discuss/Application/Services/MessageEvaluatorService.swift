//
//  MessageEvaluatorService.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 17/11/2023.
//

import Foundation

struct MessageImprovmentDTO: Identifiable, Decodable, Equatable {
  var id: String {
    improvment
  }
  let improvment: String
  let areThereMistakes: Bool
}

protocol HasMessageEvaluatorService {
  var messageEvaluatorService: MessageEvaluatorService { get }
}

protocol MessageEvaluatorService {
  func analyzeMessageForImprovments(_ message: String) async throws -> String
  func evaluateDialog(_ messages: [String]) async throws -> ChatIntermediateResultsDTO

}

final class MessageEvaluatorServiceImpl: MessageEvaluatorService {
  
  typealias Services = HasChatGPTService & HasProfileService
  
  private let services: Services
  
  init(services: Services) {
    self.services = services
  }

  func analyzeMessageForImprovments(_ message: String) async throws -> String {
    let profile = try await services.profileService.getUserInfo()
    return try await services.chatGPTService.ask(
        """
        You are tasked with assessing a user's message across various criteria, including grammar, response quality and politeness.
        1. Analyze the message on grammar mistakes and vocabulary in the sentences.
        2. If there is mistakes, provide an explanation and put it into 'explanation' field. Explanations should be in \(profile.nativeLanguage.title)
        3. Analyze vocabulary used and suggest more advanced vocabulary or phrases for this message.
        4. If there is more advanced vocabulary, put it into 'newWords' field with definition of this words. If there is no, put that this vocabulary is excellent.
        If there is at least one grammatical mistakes, areThereMistakes should be true.
            
          You need to return a response in the following format. ```.
          
          ```
          Improved version: 'here insert improvments'.
          Grammar: 'here grammar'.
          Vocabulary: 'here vocabulary'.
          AreThereMistakes: "bool"
          ```
        message - "\(message)"
    """
    )
  }
  
  func evaluateDialog(_ messages: [String]) async throws -> ChatIntermediateResultsDTO {
    fatalError()
  }
}
