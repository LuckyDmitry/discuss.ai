//
//  ChatHelpView.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 02/12/2023.
//

import Foundation
import Combine

struct ChatHelpDTO: Decodable {
  var suggest: String
  var translation: String
}

final class ChatHelpViewModel: BaseViewModel {
  typealias State = ChatHelpState
  typealias Action = ChatHelpAction
  typealias ChatHelpServices = HasChatGPTService & HasChatMessageHistoryService & HasProfileService
  
  var state: CurrentValueSubject<ChatHelpState, Never> = .init(ChatHelpState.idle)
  
  private let services: ChatHelpServices
  
  init(services: Services = .services) {
    self.services = services
  }
  
  func handle(_ action: ChatHelpAction) {
    Task {
      switch action {
      case .tapOnHelp:
        await loadAndShowSuggest()
      }
    }
  }
  
  private func loadAndShowSuggest() async {
    do {
      let profileInfo = try await services.profileService.getUserInfo()
      modify { $0 = .loading }
      let suggest: ChatHelpDTO = try await services.chatGPTService.ask("""
          I will provide you a chat history, you need to suggest a possible answer about the debate topic which is discuss.
          You also need to translate your suggestion into this language - \(profileInfo.learningLanguage.title).
          Your suggest should be in this language - \(profileInfo.nativeLanguage.title).
          Your response in the following format:
          {
              "suggest": "string,
              "translation": "string,
          }
          
          chat history: 
          ```
          \(services.chatMessageHistoryService.dialog.map { "\($0.role.rawValue): \($0.content)" }.joined(separator: "\n"))
          ```
          
          """
      )
      
      modify {
        $0 = .content(.init(suggest: suggest.suggest, translation: suggest.translation))
      }
    } catch {
      modify { $0 = .error }
    }
  }
}
