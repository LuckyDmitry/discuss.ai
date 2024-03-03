import Foundation

struct ChatDebateInterceptor: ChatInterceptor {
  private let debate: DebateQuestion
  private let isAgainst: Bool
  private var language: Language?
  private var totalRounds: Int
  
  init(debate: DebateQuestion, isAgainst: Bool, totalRounds: Int) {
    self.debate = debate
    self.isAgainst = isAgainst
    self.totalRounds = totalRounds
  }
  
  mutating func setupLanguage(_ language: Language) {
    self.language = language
  }
  
  func intercept(_ messages: [ChatUseMessage]) -> [ChatUseMessage] {
    var promt: String? = nil
    let assistantMessagesAmount = messages.filter { !$0.isCommand && $0.message.role == .assistant }.count
    
    if assistantMessagesAmount == 0 {
      promt = """
    Language: Your responses should be in \(language!.title).
    Debate Topic: Focus solely on the topic of \(debate.title).
    Role: Act as my debate partner, discreetly maintaining your AI identity.
    Objective: Your goal is to both challenge my viewpoints and convince me on the topic of \(debate.title).
    Style: Communicate in everyday language.
    Length: Aim for responses around 30 words.
    Interaction: \(isAgainst ? "You are against of this topic. You need to provide argument which supports you side and destroys mine" : "You support this question. You need to provide an arguments which supports you side and destroys mine"). At the end ask a question for me about topic.
    Begin with a greeting.
    """
    } else if assistantMessagesAmount < 2 {
      promt = "Use everyday language and aim for a response of around 30 words and provide only one argument at a time"
    } else if assistantMessagesAmount == totalRounds - 1 {
        promt = """
      At first respond a user answer and after thank a user for this conversation and say bye politely.
      """
    }
    
    if let promt {
      return messages + [.init(isCommand: true, message: .init(content: promt, role: .user))]
    }
    return messages
  }
}
