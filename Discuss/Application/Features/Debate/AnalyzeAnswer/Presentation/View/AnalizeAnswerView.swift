import SwiftUI
import ActivityIndicatorView

struct AnalizeAnswerView: SwiftUI.View {
  
  @StateObject
  var viewContext: ViewContext<AnalizeAnswerState, AnalizeAnswerAction>
  
  @State
  private var isDetailExplanationShown: ExplanationDTO.SentenceMistakeDTO?
  
  // MARK: Body
  
  var body: some SwiftUI.View {
    content
      .onAppear { viewContext.handle(.onAppear) }
      .sheet(item: $isDetailExplanationShown) { mistake in
        DetailedAnalyzeAnswerView(mistake: mistake, onClose: {
          isDetailExplanationShown = nil
        })
        .presentationDetents([.medium, .large])
      }
  }
  
  private var content: some SwiftUI.View {
    VStack {
      Text("Analysis")
        .font(.sfPro(.medium, size: 18))
      if let mistakes = viewContext.mistakes {
        ScrollView {
          ForEach(mistakes, id: \.self) { mistake in
            Button(action: {
              isDetailExplanationShown = mistake
            }, label: {
              HStack {
                Asset.Common.close
                  .swiftUIImage
                  .renderingMode(.template)
                  .resizable()
                  .bold()
                  .frame(width: 10, height: 10)
                  .foregroundColor(.white)
                  .padding(5)
                  .background(
                    Circle()
                      .fill(Asset.Colors.TxtIcons.red.swiftUIColor)
                  )
                VStack(alignment: .leading) {
                  Text(mistake.mistake)
                    .font(.sfPro(.bold, size: 16))
                  Text(mistake.corrected)
                    .font(.sfPro(.regular, size: 16))
                }
                Spacer()
                Asset.Common.backChevron.swiftUIImage
                  .rotationEffect(.degrees(180))
              }
              .contentShape(Rectangle())
            })
            .buttonStyle(.plain)
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Asset.Colors.Surfaces.Light.gray3.swiftUIColor.cornerRadius(20))
            .padding(.horizontal, 24)
          }
        }
      } else {
        ActivityIndicatorView(
          isVisible: .constant(true),
          type: .rotatingDots(count: 3)
        )
        .foregroundColor(Asset.Colors.TxtIcons.gray.swiftUIColor)
        .frame(maxWidth: 70, maxHeight: 70)
      }
    }
  }
}

#if DEBUG
struct AnalizeAnswer_Previews: PreviewProvider {

    static var previews: some SwiftUI.View {
        AnalizeAnswerView(viewContext: .preview(AnalizeAnswerState(
          mistakes: [
                .init(mistake: "It's mistake", corrected: "Bla bla bla", explanation: "Explanation it's very long and long")
              
              ]
        )))
    }
}
#endif
