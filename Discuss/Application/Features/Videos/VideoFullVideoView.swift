////
////  VideoFullVideoView.swift
////  Elizabeth
////
////  Created by Trifonov Dmitriy Aleksandrovich on 28.05.2023.
////
//
//import SwiftUI
//
//struct VideoFullVideoView: View {
//  let videoServices: VideoServices
//  let video: Video
//  let onKnowTapped: EmptyAction
//  
//  var body: some View {
//    VStack(spacing: 0) {
//      videoContainerView
//        .padding(.bottom, 24)
//      likeSubtitlesView
//        .padding(.horizontal, 16)
//        .padding(.bottom, 64)
//      quizButtonsView
//        .padding(.horizontal, 16)
//        .padding(.bottom, 65)
//    }
//    .blackBackground()
//  }
//  
//  private var videoContainerView: some View {
//    ZStack {
//      Rectangle()
//        .fill(LinearGradient(
//          colors: Colors.Gradient.blue.colors,
//          startPoint: .top,
//          endPoint: .bottom
//        ))
//        .cornerRadius(25, corners: [.bottomLeft, .bottomRight])
//      VStack {
//        Spacer()
//        VideoView(
//          viewModel: VideoViewModel(
//            services: videoServices,
//            video: video
//          )
//        )
//        .frame(width: .infinity, height: 230)
//        .cornerRadius(20)
//        .padding(.horizontal, 24)
//        Spacer()
//        PrimaryText(video.text)
//          .font(.sfPro(.medium, size: 20))
//          .padding(.horizontal, 8)
//          .padding(.vertical, 6)
//          .background {
//            RoundedRectangle(cornerRadius: 16)
//              .fill(Colors.Surface.grayOne.color)
//          }
//          .padding(.bottom, 56)
//      }
//    }
//  }
//  
//  private var quizButtonsView: some View {
//    HStack(spacing: 16) {
//      makeQuizButton(
//        title: "Translate this",
//        action: {}
//      )
//      makeQuizButton(
//        title: "I know it",
//        action: onKnowTapped
//      )
//    }
//  }
//  
//  private var likeSubtitlesView: some View {
//    HStack {
//      SecondaryButton(
//        title: "5",
//        action: { },
//        leadingImage: Asset.Video.videoHeart.swiftUIImage,
//        needsToExpand: false
//      )
//      
//      Spacer()
//      
//      SecondaryButton(
//        title: "",
//        action: { },
//        leadingImage: Asset.Video.videoSubtitles.swiftUIImage,
//        needsToExpand: false
//      )
//    }
//  }
//  
//  private func makeQuizButton(
//    title: String,
//    action: @escaping EmptyAction
//  ) -> some View  {
//    Button(action: {
//      action()
//    }) {
//      PrimaryText(title)
//        .font(.sfPro(.medium, size: 20))
//        .padding(.vertical, 24)
//        .padding(.horizontal, 28)
//        .frame(maxWidth: .infinity)
//        .background(RoundedRectangle(cornerRadius: 20).fill( Colors.Surface.grayTwo.color))
//    }
//  }
//}
//
//struct VideoFullVideoView_Previews: PreviewProvider {
//  static var previews: some View {
//    VideoFullVideoView(
//      videoServices: Services(),
//      video: VideoMock.video,
//      onKnowTapped: {}
//    )
//  }
//}
