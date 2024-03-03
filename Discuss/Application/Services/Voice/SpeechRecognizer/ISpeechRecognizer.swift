//
//  ISpeechRecognizer.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 01.06.2023.
//

import Foundation

protocol HasSpeechRecognizer: AnyObject {
  var speechRecognizer: ISpeechRecognizer { get }
}

protocol ISpeechRecognizer {
  func startRecording(_ intermediateResults: ((String) -> Void)?) throws
  func stop() async throws -> String
  func setupLanguage(_ language: Language)
}
