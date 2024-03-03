////
////  VideoPlayerView.swift
////  Elizabeth
////
////  Created by Trifonov Dmitriy Aleksandrovich on 28.05.2023.
////
//
//import Foundation
//import UIKit
//import SwiftUI
//import AVFoundation
//
//struct VideoPlayerView: UIViewRepresentable {
//  var url: URL
//  @Binding var isVideoPlaying: Bool
//  
//  func makeCoordinator() -> Coordinator {
//    Coordinator(self)
//  }
//  
//  func makeUIView(context: Context) -> UIView {
//    let uiView = UIView()
//    uiView.backgroundColor = .black
//    
//    let player = AVPlayer(url: url)
//    let playerLayer = AVPlayerLayer(player: player)
//    playerLayer.frame = uiView.bounds
//    playerLayer.videoGravity = .resizeAspect
//    uiView.layer.addSublayer(playerLayer)
//    
//    NotificationCenter.default.addObserver(
//      context.coordinator,
//      selector: #selector(Coordinator.playerItemDidReachEnd(notification:)),
//      name: .AVPlayerItemDidPlayToEndTime,
//      object: player.currentItem
//    )
//    
//    context.coordinator.player = player
//    context.coordinator.playerLayer = playerLayer
//    
//    return uiView
//  }
//  
//  func updateUIView(_ uiView: UIView, context: Context) {
//    context.coordinator.playerLayer?.frame = uiView.bounds
//    if isVideoPlaying {
//      context.coordinator.player?.play()
//    } else {
//      context.coordinator.player?.pause()
//    }
//  }
//  
//  class Coordinator: NSObject {
//    var parent: VideoPlayerView
//    var player: AVPlayer?
//    var playerLayer: AVPlayerLayer?
//    
//    init(_ parent: VideoPlayerView) {
//      self.parent = parent
//    }
//    
//    @objc func playerItemDidReachEnd(notification: Notification) {      player?.seek(to: CMTime.zero)
//      player?.seek(to: .zero)
//      player?.play()
//    }
//  }
//
//}
