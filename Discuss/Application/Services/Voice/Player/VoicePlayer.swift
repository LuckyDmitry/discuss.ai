//
//  VoicePlayer.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 01.06.2023.
//

import Foundation
import AVFoundation

@MainActor
final class VoicePlayer: NSObject, IVoicePlayer {
  private var audioPlayer: AVAudioPlayer?
  private var extraPlayer: AVAudioPlayer?
  private var onDidFinishPlaying: EmptyAction?
  
  var isPlaying: Bool {
    audioPlayer?.isPlaying ?? false
  }
  
  func play(data: Data, onDidFinishPlaying: @escaping EmptyAction) throws {
    let session = AVAudioSession.sharedInstance()
    try session.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: [.allowBluetooth, .defaultToSpeaker])
    try session.setActive(true)  
    
    self.onDidFinishPlaying = onDidFinishPlaying
    audioPlayer = try AVAudioPlayer(data: data)
    audioPlayer?.delegate = self
    audioPlayer?.prepareToPlay()
    audioPlayer?.play()
  }
  
  func play(url: URL, onDidFinishPlaying: EmptyAction?) throws {
    let session = AVAudioSession.sharedInstance()
    try session.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: [.allowBluetooth, .defaultToSpeaker])
    try session.setActive(true)
    
    self.onDidFinishPlaying = onDidFinishPlaying
    audioPlayer = try AVAudioPlayer(contentsOf: url)
    audioPlayer?.delegate = self
    audioPlayer?.prepareToPlay()
    audioPlayer?.play()
  }
  
  func playSimultaneouslyIfNeeded(url: URL) throws {
    if let extraPlayer {
      extraPlayer.stop()
      extraPlayer.currentTime = 0
    } else {
      extraPlayer = try AVAudioPlayer(contentsOf: url)
      extraPlayer?.prepareToPlay()
    }
    extraPlayer?.play()
  }
  
  func stop() {
    audioPlayer?.stop()
  }
  
  func pause() {
    audioPlayer?.pause()
  }
  
  func continiePlaying() {
    audioPlayer?.play()
  }
  
  func getDuration(data: Data) -> TimeInterval? {
    guard let audio = try? AVAudioPlayer(data: data) else {
      return nil
    }
    return audio.duration
  }
}

extension VoicePlayer: AVAudioPlayerDelegate {
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    if flag {
      onDidFinishPlaying?()
    }
  }
}
