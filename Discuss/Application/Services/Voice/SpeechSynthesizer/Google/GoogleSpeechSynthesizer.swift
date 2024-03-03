//
//  GoogleSpeechSynthesizer.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 01.06.2023.
//

import Foundation
import AVFoundation
import GoogleSignIn

final class GoogleSpeechSynthesizer: ISpeechSynthesizer {
  private struct GoogleSpeechDTO: Decodable {
    var audioContent: String
  }
  private let network: INetworkService
  private var player: AVAudioPlayer?
  private var token: String?
  
  init(network: INetworkService) {
    self.network = network
  }
  
  func textToSpeech(_ text: String) async throws -> Data {
    do {
      let speechDTO: GoogleSpeechDTO = try await network.makeRequest(GoogleSpeechSynthesizerEndpoint.recognize(text: text))
      let data = Data(base64Encoded: speechDTO.audioContent, options: .ignoreUnknownCharacters)
      guard let data else {
        throw NetworkError.requestFailed
      }
      return data
    } catch {
      throw NetworkError.requestFailed
    }
  }
}
