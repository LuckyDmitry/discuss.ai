//
//  Message.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 25.03.2023.
//

import Foundation

struct Message: Identifiable, Hashable, Codable {
  enum TranslationState: Codable, Hashable {
    case loaded(String)
    case loading
    case empty
    
    var translation: String? {
      switch self {
      case let .loaded(text):
        return text
      default:
        return nil
      }
    }
  }
  
  enum FeedBackState: Codable, Hashable {
    
    struct FeedBackMessage: Codable, Hashable {
      var isMistake: Bool
      var improvedVersion: String
      var isFullMessageShown: Bool = false
    }
    
    case loaded(FeedBackMessage)
    case loading
    case empty
    
    var isLoaded: Bool {
      switch self {
      case .loaded:
        return true
      default:
        return false
      }
    }
  }
  
  var id: Int {
    message.hashValue
  }
  
  var message: String
  var translationState: TranslationState = .empty
  var isMessagePlaying: Bool = false
  var feedBackState: FeedBackState = .empty
}

extension Message {
  static let mock = Self.init(message: "Hello dear friend")
  static let longTextMock = Self.init(message: "Baby don’t hurt me” is a phrase that means “please don’t hurt me” or “please don’t cause me emotional pain”. It can be used in varios context, such as in a plea to a romantic partner to treat the speaker kindly or in relation to any situation where the speaker feels vulnerable and is asking for protection or care. The phrase gained fame throught the 1993 song “What is Love” by Haddaway.  protection or care. The phrase gained  Love” by  Haddaway Haddaway Haddaway.")
}
