////
////  VideoViewModel.swift
////  Elizabeth
////
////  Created by Trifonov Dmitriy Aleksandrovich on 25.05.2023.
////
//
//import Foundation
//typealias VideoServices = HasVideoProvider
//
//final class VideoViewModel: ObservableObject {
//  
//  @Published
//  private(set) var videoUrlToFile: URL?
//  
//  @Published
//  var isVideoPlaying = false
//  
//  private let services: VideoServices
//  private let video: Video
//  let shouldStartPlayingOnAppear: Bool
//  
//  init(
//    services: VideoServices,
//    video: Video,
//    shouldStartPlayingOnAppear: Bool = true
//  ) {
//    self.services = services
//    self.video = video
//    self.shouldStartPlayingOnAppear = shouldStartPlayingOnAppear
//  }
//  
//  func onAppear() {
//    Task {
//      
//      let videoData = try await services.videoProvider.fetchVideo(video.videoUrl)
//      let videoUrlToFile = FileManager.default.urls(for: .cachesDirectory, in: .localDomainMask)[0].appending(path: "\(video.id)my_video.mp4")
//      try videoData.write(to: videoUrlToFile)
//      DispatchQueue.main.async {
//        self.videoUrlToFile = videoUrlToFile
//      }
//    }
//  }
//  
//  func onDissapear() {
//    isVideoPlaying = false
//  }
//  
//  func onVideoTapped() {
//    isVideoPlaying.toggle()
//  }
//  
//  deinit {
//    isVideoPlaying = false
//  }
//}
