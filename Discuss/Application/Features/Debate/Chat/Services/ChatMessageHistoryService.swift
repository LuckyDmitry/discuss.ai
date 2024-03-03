//
//  ChatMessageHistoryService.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 02/12/2023.
//

import Foundation

protocol HasChatMessageHistoryService {
  var chatMessageHistoryService: ChatMessageHistoryService { get }
  
}

final class ChatMessageHistoryService {
    
  private(set) var dialog: [ChatGPTDTO.Message] = []
  var debateQuestion: DebateQuestion!
  
  func add(_ message: ChatGPTDTO.Message) {
    dialog.append(message)
  }
  
  func clear() {
    dialog.removeAll()
  }
}
