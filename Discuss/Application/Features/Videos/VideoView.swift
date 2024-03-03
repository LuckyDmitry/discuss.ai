////
////  VideoView.swift
////  Elizabeth
////
////  Created by Trifonov Dmitriy Aleksandrovich on 25.05.2023.
////
//
//import SwiftUI
//import AVFoundation
//
//struct VideoView: View {
//  @ObservedObject
//  var viewModel: VideoViewModel
//  
//  init(viewModel: VideoViewModel) {
//    self.viewModel = viewModel
//  }
//  
//  var body: some View {
//    Group {
//      if let url = viewModel.videoUrlToFile {
//        VideoPlayerView(
//          url: url,
//          isVideoPlaying: $viewModel.isVideoPlaying
//        )
//          .border(.green)
//          .onAppear {
//            DispatchQueue.main.async {
//              if viewModel.shouldStartPlayingOnAppear {
//                viewModel.isVideoPlaying = true
//              }
//            }
//          }
//          .onDisappear {
//            viewModel.onDissapear()
//          }
//          .onTapGesture {
//            viewModel.onVideoTapped()
//          }
//      } else {
//        ProgressView()
//          .onAppear {
//            viewModel.onAppear()
//          }
//      }
//    }.blackBackground()
//  }
//}
//
//struct VideoView_Previews: PreviewProvider {
//  static var previews: some View {
//    VideoView(viewModel: .init(
//      services: Services(),
//      video: VideoMock.video)
//    )
//  }
//}
