import Foundation

struct ChatIntermediateResultsDTO: Decodable {
  struct MistakeDTO: Identifiable, Decodable, Hashable {
    let id = UUID()
    var mistake: String
    var corrected: String
    var explanation: String
  }
  
  struct VocabularyDTO: Identifiable, Decodable, Hashable {
    let id = UUID()
    var originalWord: String
    var suggestedWord: String
    var explanation: String
  }

  var mistakes: [MistakeDTO]
  var vocabulary: [VocabularyDTO]
  var wordsUsed: Int
  var score: Int
  var keyPhrases: Int
}

final class ChatResultsUseCase {
  
  typealias Services = HasChatGPTService
  
  private let services: Services
  
  init(services: Services) {
    self.services = services
  }
  
  func getIntermediateResults(_ message: [String]) async throws -> ChatIntermediateResultsDTO {
    try await services.chatGPTService.ask("""
    You have to return only json!
    You are tasked with assessing a user's message across various criteria, including grammar, response quality, relevance of arguments, and politeness. Your goal is to generate a numerical score within a range of 0 to 100, where a higher score reflects a better response (to be stored in the 'score' field). A better response contains more words and has no grammar mistakes.
         Additionally, you should analyze the message for opportunities to suggest alternative words, providing an explanation for the word choice and including an example sentence in the 'vocabulary' field. Lastly, review the message for any mistakes and provide corrections along with explanations in the 'mistakes' field. For mistake you need to provide a sentence in which there is a mistake and write down corrected sentence.
      For originalWord and suggestedWord you need to provide more context around these words.
        
      You need to return a response in json format. I'll provide you a json in ```.
      
      ```
      {
        "wordsUsed": "int",
        "score": "Int",
        "keyPhrases": "Int",
        "vocabulary": [
          {
            "originalWord": "String",
            "suggestedWord": "String",
            "explanation": "String"
          }
        ],
        "mistakes": [
          {
            "mistake": "String",
            "corrected": "String",
            "explanation": "String"
          }
        ]
      }
      ```
    message - "\(message)"
""")
  }
}
