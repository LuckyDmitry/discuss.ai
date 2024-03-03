import SwiftUI
import ConfettiSwiftUI

struct ChatState: Equatable {
  var debateTitle: String
  var chatViewBlocks: [ChatViewBlock] = []
  var isRecording: Bool = false
  var isInputHidden: Bool = true
  var currentRating = 0
  var totalRounds: Int
  var currentRound = 0
}

enum ChatAction {
  case viewAppeared
  case viewDissappeared
  case tapExitLesson
  case tapCancelRecording
  case tapStartRecording
  case tapStopRecording
  case tapOnHelp
}

struct RoundsProgressView: View {
  var totalRounds: Int
  @Binding var currentRound: Int
  
  private let completedColor = Asset.Colors.Surfaces.Dark.green.swiftUIColor
  private let upcomingColor = Asset.Colors.Surfaces.gray2.swiftUIColor

  var body: some View {
    HStack(spacing: 0) {
      ForEach(0..<totalRounds, id: \.self) { round in
        ZStack {
          Circle()
            .stroke(lineWidth: 2)
            .foregroundColor(upcomingColor)
            .frame(width: 30, height: 30)
          
          Circle()
            .trim(from: 0, to: round < currentRound ? 1 : 0)
            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
            .foregroundColor(completedColor)
            .frame(width: 30, height: 30)
            .animation(.linear(duration: 0.6).delay(0.3), value: currentRound)
        }
        .transition(.slide)
        .animation(.easeInOut, value: currentRound)

        if round < totalRounds - 1 {
          ZStack {
            Rectangle()
              .frame(height: 2)
              .foregroundColor(.clear)
              .transition(.opacity)
              .animation(.linear(duration: 0.3).delay(0.3), value: currentRound)
            Rectangle()
              .trim(from: 0.0, to: round < currentRound - 1 ? 1 : 0)
              .frame(height: 2)
              .foregroundColor(completedColor)
//              .transition(.opacity)
              .animation(.linear(duration: 0.3), value: currentRound)
          }
        }
      }
    }
    .padding()
  }
}


struct ChatView: View {
  
  typealias ChatViewContext = ViewContext<ChatState, ChatAction>
  
  @StateObject
  private var viewContext: ChatViewContext
  
  @State
  private var exitConfrirmationAlertShown = false
  
  init(viewContext: ChatViewContext) {
    self._viewContext = StateObject(wrappedValue: viewContext)
  }
  
  var body: some View {
    contentView
      .edgesIgnoringSafeArea(.bottom)
      .onAppear {
        viewContext.handle(.viewAppeared)
      }
      .onDisappear {
        viewContext.handle(.viewDissappeared)
      }
      .alert(
        "Are you sure you want to exit the lesson?",
        isPresented: $exitConfrirmationAlertShown,
        actions: {
          exitAlertView
        }
      )
  }
  
  var contentView: some View {
    VStack(spacing: 0) {
      VStack(alignment: .leading) {
        DebateHeaderView(
          title: viewContext.debateTitle,
          onCloseTap: {
            exitConfrirmationAlertShown = true
          }
        )
//        RoundsProgressView(
//          totalRounds: viewContext.totalRounds,
//          currentRound: .constant(viewContext.currentRound)
//        )
//        .padding(.horizontal)
        //        ZStack(alignment: .leading) {
        //          GeometryReader { reader in
        //            let fillingWidth = reader.size.width * (CGFloat(viewContext.currentRating) / 100)
        //            RoundedRectangle(cornerRadius: 20)
        //              .fill(Color(red: 242 / 255, green: 228 / 255, blue: 214 / 255))
        //              .overlay(alignment: .leading) {
        //                RoundedRectangle(cornerRadius: 20)
        //                  .fill(Color(red: 236 / 255, green: 202 / 255, blue: 96 / 255))
        //                  .frame(width: fillingWidth)
        //                  .overlay(alignment: .top) {
        //                    RoundedRectangle(cornerRadius: 3)
        //                      .fill(.white)
        //                      .opacity(0.4)
        //                      .frame(width: fillingWidth - 20, height: 2)
        //                      .padding(.top, 2)
        //                  }
        //              }
        //          }
        //        }
        //        .frame(height: 10)
        //        .padding(.horizontal)
        //        .animation(.linear, value: viewContext.currentRating)
        
        ZStack(alignment: .bottom) {
          messagesView
            .background(Color(red: 226 / 255, green: 237 / 255, blue: 242 / 255))
          footerView
        }
      }
    }
  }
  
  @ViewBuilder
  private var exitAlertView: some View {
    Button(
      role: .cancel,
      action: { exitConfrirmationAlertShown = false },
      label: { Text("Cancel") })
    Button(
      action: { viewContext.handle(.tapExitLesson) },
      label: { Text("Exit") })
  }
  
  @ViewBuilder
  private var messagesView: some View {
    ScrollView {
      ForEach(viewContext.chatViewBlocks.reversed()) { block in
        ChatViewBlockContainer(
          chatViewBlock: block,
          onHelpTap: { viewContext.handle(.tapOnHelp) }
        )
        .padding(.top, viewContext.chatViewBlocks.first == block ? 30.0 : 0)
        .padding(.bottom, viewContext.chatViewBlocks.last == block ? 100 : 0)
        .flippedUpsideDown()
        .padding(.horizontal)
      }
    }
    .clipped()
    .flippedUpsideDown()
    .animation(.discussInteractiveSring, value: viewContext.chatViewBlocks)
  }
  
  private var footerView: some View {
    HStack {
      if !viewContext.isInputHidden {
        if viewContext.isRecording {
          Button(action: {
            simpleSuccess()
            viewContext.handle(.tapCancelRecording)
          }, label: {
            Asset.Common.close.swiftUIImage
              .renderingMode(.template)
              .resizable()
              .foregroundColor(.black)
              .frame(width: 20, height: 20)
              .padding(10)
              .background {
                Circle()
                  .foregroundColor(Color(red: 242 / 255, green: 244 / 255, blue: 245 / 255))
              }
          })
        }
        micView
          .alignmentGuide(.horizontalCenterAlignment) {
            $0[HorizontalAlignment.center]
          }
          .padding(.leading, 10)
          .padding(.top, 10)
      }
    }
    .animation(.default, value: viewContext.isInputHidden)
    .frame(maxWidth: .infinity, minHeight: 60, alignment: Alignment(
      horizontal: .horizontalCenterAlignment,
      vertical: .verticalCenterAlignment
    ))
    .padding(.bottom, 30)
    .background {
      RoundedRectangle(cornerRadius: 70)
        .fill(.white)
        .opacity(0.95)
        .blur(radius: 1)
    }
  }
  
  @ViewBuilder
  private var micView: some View {
    Button(action: {
      simpleSuccess()
      if !viewContext.isRecording {
        simpleSuccess()
        viewContext.handle(.tapStartRecording)
      } else {
        viewContext.handle(.tapStopRecording)
      }
    }, label: {
      VoiceRecordingView(
        isRecording: viewContext.isRecording,
        size: 60
      )
    })
  }
}

struct ChatView_Previews: PreviewProvider {
  static var previews: some View {
    ChatView(viewContext: .preview(.init(
      debateTitle: "Planets · Round 1",
      chatViewBlocks: [
        .init(alignment: .bot, content: .plain("Hi, how are doing?")),
        .init(alignment: .user, content: .plain("Yeah, I'm good")),
      ],
      isRecording: true,
      isInputHidden: false,
      currentRating: 40,
      totalRounds: 5,
      currentRound: 5
    )))
  }
}

private enum Constants {
  static let micScale: CGFloat = 1.6
}
