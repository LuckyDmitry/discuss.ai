////
////  VideoContainerViewModel.swift
////  Elizabeth
////
////  Created by Trifonov Dmitriy Aleksandrovich on 06.06.2023.
////
//
//import Foundation
//
//final class VideoContainerViewModel: ObservableObject {
//
//  @Published
//  private(set) var currentIndex = 0
//
//  @Published
//  private(set) var videos: [Video] = []
//
//  @Published
//  private(set) var currentVideo: Video
//
//  init(videos: [Video], currentVideo: Video) {
//    self.videos = videos
//    self.currentVideo = currentVideo
//
//    $currentIndex
//      .map { videos[$0] }
//      .assign(to: &$currentVideo)
//  }
//  
//  func onAppear() {
//
//  }
//
//  func backPressed() {
//    currentIndex -= 1
//  }
//
//  func onIKnowTapped() {
//    currentIndex += 1
//  }
//}
