import Foundation

struct ChatEvaluatorInterceptor: ChatInterceptor {
  private let debate: DebateQuestion
  private let isAgainst: Bool
  
  init(debate: DebateQuestion, isAgainst: Bool) {
    self.debate = debate
    self.isAgainst = isAgainst
  }
  
  func intercept(_ messages: [ChatUseMessage]) -> [ChatUseMessage] {
    let dialog = messages.filter { !$0.isCommand }
    let assistantMessages = dialog.filter { $0.message.role == .assistant }.count
    
    let promt = """
      I will provide you a debate messages on this topic - \(debate.title). You need to access the relevance of user arguments and provide a give a score from 0 to \(assistantMessages > 2 ? "100" : "60"). I will give you user arguments with mark "user" and bot arguments with "bot".
      Provide a response with json in the following format:
      
      { "score": "int"}
      
      dialog:
      \(dialog.map { ($0.message.role == .assistant ? "bot:" : "user:") + $0.message.content }.joined(separator: "\n"))
      """
  
    return [.init(isCommand: true, message: .init(content: promt, role: .user))]
  }
}
