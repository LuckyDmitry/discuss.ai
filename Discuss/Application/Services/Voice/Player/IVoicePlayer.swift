//
//  VoicePlayer.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 01.06.2023.
//

import Foundation

protocol HasVoicePlayer: AnyObject {
  var voicePlayer: IVoicePlayer { get }
}

protocol IVoicePlayer {
  func getDuration(data: Data) -> TimeInterval?
  func play(data: Data, onDidFinishPlaying: @escaping EmptyAction) throws
  func play(url: URL, onDidFinishPlaying: EmptyAction?) throws
  func playSimultaneouslyIfNeeded(url: URL) throws 
  func stop()
  func pause()
  func continiePlaying()
  
  var isPlaying: Bool { get }
}
