import Foundation

enum Role: String, Encodable {
  case user
  case assistant
  case system
}

enum ChatGPTDTO {
  struct Message: Encodable {
    var content: String
    var role: Role
  }
  
  struct Input: Encodable {
    var messages: [Message]
    var isJsonResponse: Bool = false
    var model: String = "gpt-4"
  }
  
  struct Output: Decodable {
    struct Choice: Decodable {
      struct Message: Decodable {
        var content: String
      }
      var message: Message
    }
    
    @DefaultEmptyLossyArray
    var choices: [Choice] = []
  }
}
