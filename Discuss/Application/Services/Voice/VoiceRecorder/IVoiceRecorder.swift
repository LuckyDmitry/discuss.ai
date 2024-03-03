//
//  IVoiceRecorder.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 01.06.2023.
//

import Foundation

protocol HasVoiceRecorder {
  var voiceRecorder: IVoiceRecorder { get }
}

protocol IVoiceRecorder {
  var isRecording: Bool { get }
  func startRecording() throws
  func stopRecording() throws -> URL
}
