import Foundation
import AVFoundation

final class OpenAISpeechSynthesizer: ISpeechSynthesizer {

  private let network: INetworkService

  init(network: INetworkService) {
    self.network = network
  }
  
  func textToSpeech(_ text: String) async throws -> Data {
    return try await network.makeDataRequest(OpenAISpeechSynthesizerEndpoint.recognize(text))
  }
}
