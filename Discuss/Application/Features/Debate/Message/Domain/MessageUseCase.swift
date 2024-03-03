//
//  MessageUseCase.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 01/12/2023.
//

import Foundation
import Combine

final class MessageUseCase {
  
  typealias MessageServices = HasMessageEvaluatorService & HasTranslationService & HasProfileService & HasVoicePlayer & HasPlayingListener & HasSpeechSynthesizer
  private let services: MessageServices
  private var translation: String?
  private var playingData: Data?
  private var cancellables = Set<AnyCancellable>()
  private let message: String
  
  var currentMessagePlaying = CurrentValueSubject<Bool, Never>.init(false)
  
  init(services: MessageServices = Services.services, message: String) {
    self.services = services
    self.message = message
    setup()
  }
  
  func improvmentsForMessage(_ message: String) async throws -> String {
    return try await services.messageEvaluatorService.analyzeMessageForImprovments(message)
  }
  
  func translateMessage(_ message: String) async throws -> String {
    if let translation {
      return translation
    }
    let userInfo = try await services.profileService.getUserInfo()
    let translation = try await services.translationService.translate(
      text: message,
      originalLanguage: userInfo.learningLanguage,
      targetLanguge: userInfo.nativeLanguage
    )
    self.translation = translation
    return translation
  }
  
  func stopPlayingMessage() async throws {
    services.voicePlayer.stop()
    services.playingListener.stopPlaying(message)
  }

  func playingMessage(_ message: String) async throws {
    if let playingData {
      try playData(playingData)
      return
    }
    
    let playingData = try await services.speechSynthesizer.textToSpeech(message)
    self.playingData = playingData
    try playData(playingData)
  }

  private func setup() {
    services.playingListener.playingItem.sink { [weak self] playingMessage in
      guard let self else { return }
      guard let playingMessage else {
        self.currentMessagePlaying.send(false)
        return
      }
      self.currentMessagePlaying.send(playingMessage == self.message)
    }
    .store(in: &cancellables)
    
    services.playingListener.playingItemFinished.sink { [weak self] finishedMessage in
      if finishedMessage == self?.message {
        self?.currentMessagePlaying.send(false)
      }
    }
    .store(in: &cancellables)
  }
  
  private func playData(_ data: Data) throws {
    services.playingListener.startPlaying(message)
    try services.voicePlayer.play(data: data) { [weak self] in
      guard let self else { return }
      self.services.playingListener.stopPlaying(self.message)
    }
  }
}
