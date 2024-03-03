//
//  MessageType.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 30.05.2023.
//

import Foundation

struct Actionable: Hashable {
  var id = UUID()
  var action: EmptyAction
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

struct ChatViewBlock: Hashable, Identifiable {
  enum BlockAlignment: Hashable {
    case center
    case bot
    case user
    
    var isBot: Bool {
      return self == .bot
    }
  }
  
  enum MessageContent: Identifiable, Hashable {
    var id: Self {
      self
    }
    
    case plain(String)
    case loading
    case error(String)
    case roundDivider(round: Int)
    case help
    
    var text: String? {
      switch self {
      case .plain(let message):
        return message
      default:
        return nil
      }
    }
    
    var isError: Bool {
      switch self {
      case .error:
        return true
      default:
        return false
      }
    }
    
    var isPlainMessage: Bool {
      text != nil
    }    
  }
  var id: MessageContent {
    content
  }
  
  var alignment: BlockAlignment
  var content: MessageContent
}

extension ChatViewBlock {
  init(alignment: BlockAlignment, message: String) {
    self.init(alignment: alignment, content: .plain(message))
  }
}
