import Foundation

enum ChatGPTRequest: BaseRequest {
  private static let API_KEY = "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"
  case request(ChatGPTDTO.Input)
  
  var url: URL {
    switch self {
    case .request:
      return URL(string: "https://api.openai.com/v1/chat/completions")!
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .request:
      return [
        "Authorization": "Bearer \(ChatGPTRequest.API_KEY)",
        "Content-Type": "application/json"
      ]
    }
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .request:
      return .post
    }
  }
  
  var body: Data? {
    switch self {
    case .request(let input):
      let jsonObject: [String: Decodable] = [
        "model" : "gpt-3.5-turbo",
        "stream": false,
        "messages": input.messages.map {
          [
            "content": $0.content,
            "role": $0.role.rawValue
          ]
        }
      ]
      
      return try? JSONSerialization.data(withJSONObject: jsonObject)
    }
  }
}
