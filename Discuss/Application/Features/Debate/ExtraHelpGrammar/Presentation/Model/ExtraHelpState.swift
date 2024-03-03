struct ExtraHelpState: Equatable {
  struct Vocabulary: Equatable {
    var word: String
    var meaning: String
  }
  
  struct Content: Equatable {
    enum Translation: Equatable {
      case idle
      case loading
      case loaded(Vocabulary)
      
      var isLoading: Bool {
        self == .loading
      }
    }
    
    var translation: Translation = .idle
    var original: Vocabulary
  }
  var vocabulary: [Content]
}
