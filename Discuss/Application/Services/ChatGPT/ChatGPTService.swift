import Foundation

enum ChatGPTError: Error {
  case jsonConvertingError
}

final class ChatGPTService: IChatGPTService {
  private let network: INetworkService
  
  init(network: INetworkService) {
    self.network = network
  }
  
  func askWithHistory(_ messagesHistory: [ChatGPTDTO.Message]) async throws -> String {
    try await internalAskWithHistory(messagesHistory)
  }
  
  func ask(_ message: String) async throws -> String {
    return try await askWithHistory([.init(content: message, role: .user)])
  }
  
  func ask<Object>(_ message: String) async throws -> Object where Object : Decodable {
    let jsonString = try await internalAskWithHistory([.init(content: message, role: .user)], isJson: true)
    guard let data = jsonString.data(using: .utf8) else {
      throw ChatGPTError.jsonConvertingError
    }
    return try JSONDecoder().decode(Object.self, from: data)
  }
  
  private func internalAskWithHistory(_ messagesHistory: [ChatGPTDTO.Message], isJson: Bool = false) async throws -> String {
    do {
      let response: ChatGPTDTO.Output = try await network.makeRequest(ChatGPTRequest.request(.init(
        messages: messagesHistory,
        isJsonResponse: isJson
      )))
      if let message = response.choices.first?.message.content {
        return message
      }
      throw NetworkError.requestFailed
    } catch {
      print(error.localizedDescription)
      throw error
    }
  }
}
