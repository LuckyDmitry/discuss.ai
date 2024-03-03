////
////  VideoContainerView.swift
////  Elizabeth
////
////  Created by Trifonov Dmitriy Aleksandrovich on 06.06.2023.
////
//
//import SwiftUI
//
//struct VideoContainerView: View {
//  typealias Services = HasVideoProvider
//  
//  @State
//  private var index = 0
//  
//  var services: Services
//  
//  @StateObject
//  var viewModel: VideoContainerViewModel
//  
//  var body: some View {
//    ZStack(alignment: .top) {
//      VideoFullVideoView(
//        videoServices: services,
//        video: viewModel.currentVideo,
//        onKnowTapped: { viewModel.onIKnowTapped() }
//      )
//      HStack(spacing: 14) {
//        if index != 0 {
//        ZStack {
//          Circle()
//            .fill(.white)
//            .frame(width: 23, height: 23)
//            .onTapGesture {
//              withAnimation {
//                viewModel.backPressed()
//              }
//            }
//          
//            Image(systemName: "chevron.left")
//              .foregroundColor(Colors.TextAndIcons.gray2.color)
//              .transition(.scale)
//          }
//        }
//        
//        ProgressView(
//          value: CGFloat(index),
//          total: CGFloat(viewModel.videos.count)
//        )
//        .tint(.white)
//        .progressViewStyle(LinearProgressViewStyle())
//        .frame(height: 8)
//      }
//    }
//    .background(Colors.Background.main.color)
//    .animation(.default, value: viewModel.currentIndex)
//  }
//}
//
////struct VideoContainerView_Previews: PreviewProvider {
////  static var previews: some View {
////    VideoContainerView()
////  }
////}
