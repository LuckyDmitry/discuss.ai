import SwiftUI
import ActivityIndicatorView
import FirebaseStorage

//struct DebateListView: View {}
  
//  @StateObject
//  var viewContext: ViewContext<DebateViewState, DebateViewAction>
//  
//  var body: some View {
//    VStack {
//      if let topics = viewContext.topics {
//        VStack {
//          contentView(topics)
//            .padding(.top, 20)
//        }
//        .frame(maxHeight: .infinity)
//      } else {
//        loadingView
//          .frame(width: 70, height: 70)
//      }
//    }
//    .onAppear {
//      viewContext.handle(.onAppear)
//    }
//    .toolbar {
//      ToolbarItem(placement: .navigationBarLeading) {
//        Button(action: {
//          
//        }, label: {
//          HStack(spacing: 4) {
//            Text("Beginner")
//              .font(.sfPro(.bold, size: 16))
//            Asset.Common.chevronDown.swiftUIImage
//              .renderingMode(.template)
//              .resizable()
//              .frame(width: 20, height: 20)
//              .foregroundColor(.black)
//          }
//        })
//        .buttonStyle(.plain)
//      }
//      ToolbarItem {
//        HStack(spacing: 4) {
//          Text("1")
//            .font(.sfPro(.bold, size: 14))
//          Asset.Profile.fire.swiftUIImage
//            .resizable()
//            .frame(width: 20, height: 20)
//        }
//      }
//    }
//    .background(Color(red: 243 / 255, green: 243 / 255, blue: 243 / 255))
//  }
//  
//  private func contentView(_ topics: [DebateQuestion]) -> some View {
//    ScrollView {
//      VStack(spacing: 16) {
//        ForEach(topics, id: \.questionId) { topic in
//          Button(action: {
//            
//          }, label: {
//            HStack {
//              Asset.image.swiftUIImage
//                .resizable()
//                .frame(width: 70, height: 70)
//                .cornerRadius(25)
//              VStack(alignment: .leading) {
//                Text(topic.title)
//                  .font(.sfPro(.medium, size: 16))
//                  .multilineTextAlignment(.leading)
//              }
//              Spacer()
//            }
//            .padding(.horizontal, 10)
//            .padding(.vertical, 10)
//            .frame(maxWidth: .infinity)
//            .background {
//              RoundedRectangle(cornerRadius: 20)
//                .fill(.white)
//            }
//            .padding(.horizontal, 20)
//          })
//          .buttonStyle(PressedButtonStyle())
//          
//        }
//      }
//    }
//  }
//  
//  private var loadingView: some View {
//    ActivityIndicatorView(isVisible: .constant(true), type: .arcs(count: 2, lineWidth: 1))
//  }
//}
//
//struct DebateListView_Previews: PreviewProvider {
//  static var previews: some View {
//    NavigationStack {
//      DebateListView(viewContext: .preview(.init(
//        topics: [],
//        currentLanguageLevel: .advanced,
//        currentTopic: .health
//      )))
//    }
//  }
//}

struct PressedButtonStyle: ButtonStyle {
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.95 : 1)
      .animation(.easeInOut, value: configuration.isPressed)
  }
}
