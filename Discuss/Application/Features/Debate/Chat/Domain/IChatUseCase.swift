import Foundation
import Combine

protocol IChatUseCase {
  var isPlayingMessageFinished: AnyPublisher<Void, Never> { get }
  
  func startRecording(_ onPartialResuts: @escaping (String) -> Void) async throws
  func stopRecording() async throws -> String
  func cancelRecording() async throws
  func sendMessage(_ message: String) async throws -> String
  func requestCurrentRating() async throws -> Int
  func playSuccess()

  func start() async throws -> String
  func exit() async throws
}
