//
//  MessageViewState.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 01/12/2023.
//

import Foundation


struct MessageViewState: Equatable {
  
  typealias FeedBackState = LoadableDataState<FeedBackContext>
  typealias TranslationState = LoadableDataState<TranslationContext>
  
  struct FeedBackContext: Equatable {
    var isImprovmentsShown = false
    var improvments: String
    var areThereMistakes: Bool
  }
  
  struct TranslationContext: Equatable {
    var translation: String = ""
  }
  
  var isBotMessage: Bool
  var message: String
  var isPlaying: Bool = false
  var feedBackState: FeedBackState = .idle
  var translationState: TranslationState = .idle
}
