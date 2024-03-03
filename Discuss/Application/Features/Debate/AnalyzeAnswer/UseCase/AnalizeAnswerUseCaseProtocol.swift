import Foundation

struct ExplanationDTO: Decodable {

  struct SentenceMistakeDTO: Identifiable, Decodable, Hashable {
    let id = UUID()
    var mistake: String
    var corrected: String
    var explanation: String
  }

  var mistakes: [SentenceMistakeDTO]
}

protocol AnalizeAnswerUseCaseProtocol {
  func requestExplanation() async throws -> ExplanationDTO
}
