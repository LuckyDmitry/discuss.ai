//
//  PlayingServiceListener.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 02/12/2023.
//

import Foundation
import Combine

protocol HasPlayingListener {
  var playingListener: PlayingServiceListener { get }
}

final class PlayingServiceListener {
  
  let playingItem = CurrentValueSubject<String?, Never>(nil)
  let playingItemFinished = CurrentValueSubject<String?, Never>.init(nil)
  
  func startRecording() {
    playingItem.send(nil)
    playingItemFinished.send(playingItemFinished.value)
  }
  
  func stopPlaying(_ message: String) {
    playingItem.send(nil)
    playingItemFinished.send(message)
  }
  
  func startPlaying(_ message: String) {
    playingItem.send(message)
    playingItemFinished.send(nil)
  }
}
