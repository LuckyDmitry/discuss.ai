import Foundation
import AVFoundation

final class PlayHTSpeechSynthesizer: ISpeechSynthesizer {
  private struct PlayHTSpeechDTO: Decodable {
      var stage: String
      var url: String?
  }
    
  private let network: INetworkService
  private var player: AVAudioPlayer?
  
  init(network: INetworkService) {
    self.network = network
  }
  
  func textToSpeech(_ text: String) async throws -> Data {
    fatalError()
  }
}
