import SwiftUI
import Combine

struct VoiceRecordingView: View {
  var isRecording: Bool
  var size: CGFloat = 40
  
  @State
  private var innerAnimation: Bool = false
  
  var body: some View {
    ZStack {
      if isRecording {
        ZStack {
          Circle()
            .frame(width: size, height: size)
            .foregroundColor(Asset.Colors.Surfaces.Dark.gray2.swiftUIColor)
            .opacity(0.5)
            .scaleEffect(innerAnimation ? 1.4 : 1, anchor: .center)
            .animation(innerAnimation ? .easeOut(duration: 1)
              .repeatForever(autoreverses: true).delay(0.3)
                       : .default, value: innerAnimation)
          Circle()
            .frame(width: size, height: size)
            .foregroundColor(Asset.Colors.Surfaces.Dark.gray2.swiftUIColor)
            .opacity(0.7)
            .scaleEffect(innerAnimation ? 1.2 : 1, anchor: .center)
            .animation(innerAnimation ? .easeOut(duration: 1)
              .repeatForever(autoreverses: true).delay(0.2)
                       : .default, value: innerAnimation)
          Circle()
            .frame(width: size, height: size)
            .foregroundColor(Asset.Colors.Surfaces.Dark.gray2.swiftUIColor)
            .scaleEffect(innerAnimation ? 1.1 : 1, anchor: .center)
            .animation(innerAnimation ? .easeOut(duration: 1)
              .repeatForever(autoreverses: true).delay(0.1)
                       : .default, value: innerAnimation)
        }
        .onAppear {
          innerAnimation = true
        }
        .onDisappear {
          innerAnimation = false
        }
      } else {
        Circle()
          .frame(width: size, height: size)
          .foregroundColor(Asset.Colors.Surfaces.Dark.gray2.swiftUIColor)
      }
    }
    .animation(.spring(), value: isRecording)
    .overlay {
      image
        .padding(size / 4)
        .transition(.scale)
        .animation(.easeInOut, value: isRecording)
    }
  }
  
  func timeIntervalString(from timeInterval: TimeInterval) -> String {
    let tmv = timeval(tv_sec: Int(timeInterval), tv_usec: 0)
    let dur = Duration(tmv)
    return dur
      .formatted(.time(pattern: .minuteSecond))
  }
  
  var image: some View {
    (isRecording ? Asset.Chat.arrowUp.swiftUIImage : Image(systemName: "mic.fill"))
      .resizable()
      .renderingMode(.template)
      .foregroundColor(.white)
      .scaledToFit()
  }
}

struct RecordingAnimation_Previews: PreviewProvider {
  
  @State
  static var isRecording = true
  
  static var previews: some View {
    VStack {
      VoiceRecordingView(isRecording: isRecording)
      Button("Tap", action: {
        isRecording.toggle()
      })
    }
  }
}
