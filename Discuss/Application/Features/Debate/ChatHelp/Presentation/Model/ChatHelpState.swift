//
//  ChatHelpState.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 02/12/2023.
//

import Foundation

typealias ChatHelpState = LoadableDataState<ChatHelpContext>

struct ChatHelpContext: Equatable {
  var suggest: String
  var translation: String
}
