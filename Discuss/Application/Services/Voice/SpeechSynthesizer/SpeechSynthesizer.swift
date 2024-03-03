//
//  SpeechSynthesizer.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 01.06.2023.
//

import Foundation
import AVFoundation

protocol HasSpeechSynthesizer: AnyObject {
  var speechSynthesizer: ISpeechSynthesizer { get }
}

protocol ISpeechSynthesizer {
  func textToSpeech(_ text: String) async throws -> Data
}
