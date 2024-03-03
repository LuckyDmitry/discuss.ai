import Foundation

enum LoadableDataState<Content: Equatable>: Equatable {
  case idle
  case loading
  case content(Content)
  case error
  
  var content: Content? {
    switch self {
    case let .content(content):
      return content
    default:
      return nil
    }
  }
  
  var isContent: Bool {
    content != nil
  }
  
  mutating func update(_ update: (inout Content) -> Void) {
    guard var content else {
      assertionFailure()
      return
    }
    
    update(&content)
    self = .content(content)
  }
}

struct ChatResultsState: Equatable {
  var round: Int
  var isFinishScreen: Bool
  var keyPhrases: Int
  var wordsUsed: Int
  var score: Int
  var mistakes: [ChatResultsCorrectionsView.SuggestItem]
  var vocabulary: [ChatResultsCorrectionsView.SuggestItem]
}
