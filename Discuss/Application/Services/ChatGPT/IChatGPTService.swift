import Foundation
import Combine

protocol HasChatGPTService: AnyObject {
  var chatGPTService: IChatGPTService { get }
}

protocol IChatGPTService {
  func askWithHistory(_ messagesHistory: [ChatGPTDTO.Message]) async throws -> String
  func ask(_ message: String) async throws -> String
  func ask<Object: Decodable>(_ message: String) async throws -> Object
}
