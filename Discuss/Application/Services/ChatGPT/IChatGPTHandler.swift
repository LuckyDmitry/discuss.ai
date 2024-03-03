import Foundation
import Combine

protocol IChatGPTHandler {
  func process(_ response: ChatGPTDTO.Output) async throws -> ChatGPTDTO.Output
}
