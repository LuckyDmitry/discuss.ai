import Foundation

final class AnalizeAnswerUseCase: AnalizeAnswerUseCaseProtocol {
  
  typealias Services = HasChatGPTService
  
  // MARK: Private properties
  
  private let services: Services
  private let debate: DebateQuestion
  private let message: ChatIntermediateMessage
  
  // MARK: Initialization
  
  init(
    services: Services,
    debate: DebateQuestion,
    message: ChatIntermediateMessage
  ) {
    self.services = services
    self.debate = debate
    self.message = message
  }
  
  // MARK: Internal methods
  
  func requestExplanation() async throws -> ExplanationDTO {
    try await services.chatGPTService.ask(
    """
    I will provide you an answer on debate topic "\(debate.title)"
    Also if you see any english mistakes or words and phrases which don't suit this context, you need to correct them and provide an explanation with reference to concrete grammar topic. You need to provide a response in JSON format. I will provide you a json example in quotes.

    ```
    {
        "mistakes": [
          {
            "mistake": "string",
            "corrected": "string",
            "explanation": "string"
          }
        ]
    }
    ```

    original text = "\(message.message)"
    """
    )
  }
}
