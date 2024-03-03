import SwiftUI
import Combine
import SwiftUIIntrospect

struct DebateCardsView: View {
  typealias DebateViewContext = ViewContext<DebateViewState, DebateViewAction>
  
  @StateObject
  private var viewContext: DebateViewContext
  
  @State
  private var isDetailsShown = false
  
  init(viewContext: DebateViewContext) {
    self._viewContext = StateObject(wrappedValue: viewContext)
  }
  
  var body: some View {
    VStack {
      contentView
    }
    .onFirstAppear {
      viewContext.handle(.onAppear)
    }
    .animation(.interactiveSpring(response: 0.45, dampingFraction: 0.86, blendDuration: 0.7), value: isDetailsShown)
    .toolbar(.hidden)
    .onChange(of: isDetailsShown) {
      viewContext.handle(.viewDisplayChanged(detailed: $0))
    }
  }
  
  private var contentView: some View {
    VStack {
      headerView
      Spacer()
      ZStack {
        switch viewContext.state {
        case .error:
          errorView
        case .loading, .idle:
          PrimaryLoader()
        case let .content(content):
          if content.questions.isEmpty {
            finishQuestionsView
          } else {
            cardsView(content.questions)
              .animation(.default, value: content.questions)
          }
        }
      }
      Spacer()
      chooseSideButtonsView
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: isDetailsShown ? .top : .center)
  }
  
  @ViewBuilder
  private var headerView: some View {
    if !isDetailsShown {
      HStack(spacing: 0) {
        Text("Topics to discuss")
          .font(.sfPro(.bold, size: 28))
          .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
        Text("2")
          .font(.sfPro(.bold, size: 14))
        Asset.Profile.fire.swiftUIImage
      }
      .padding(.horizontal)
      .padding(.top)
    }
  }
  
  private func cardsView(_ questions: [DebateQuestion]) -> some View {
    ForEach(questions.enumerated().reversed().map { $0 }, id: \.element) {
      let index = $0.offset
      let question = $0.element
        TinderCardView(
          question: question,
          onCloseTap: {
            viewContext.handle(.tapOnClose)
          },
          onCardTap: {
            viewContext.handle(.tapOnCard)
          },
          onVocaularyTap: {
            viewContext.handle(.tapOnHint)
          },
          cardIndex: index,
          isDetailShown: $isDetailsShown
        )
        .padding(.vertical, isDetailsShown ? 0 : 40)
        .padding(isDetailsShown ? 0 : 20)
        .scaleEffect(isDetailsShown && index != 0 ? 0.3 : 1)
    }
  }
  
  @ViewBuilder
  private var finishQuestionsView: some View {
    VStack {
      Spacer()
      Asset.Chat.drum.swiftUIImage
        .resizable()
        .frame(width: 100, height: 100)
      Text("You did it!")
        .font(.sfPro(.bold, size: 24))
        .foregroundColor(Asset.Colors.TxtIcons.Light.gray1.swiftUIColor)
        .padding(.top, 28)
      Spacer()
      PrimaryButton(
        action: {
          viewContext.handle(.tapOnReloadCards)
        },
        text: "Get more questions",
        colorSheme: .black
      )
      .padding(.horizontal, 40)
      .padding(.bottom, 40)
    }
    .transition(.opacity)
  }
  
  @ViewBuilder
  private var errorView: some View {
    VStack {
      Spacer()
      Asset.Common.toolError.swiftUIImage
        .resizable()
        .frame(width: 100, height: 100)
      Text("Something broken")
        .font(.sfPro(.bold, size: 20))
        .foregroundColor(Asset.Colors.TxtIcons.Light.gray1.swiftUIColor)
        .padding(.top, 28)
      Text("Try again. If the problem persists, try again later. We are probably already trying to fix everything")
        .font(.sfPro(.regular, size: 14))
        .foregroundColor(Asset.Colors.TxtIcons.Light.gray1.swiftUIColor)
        .padding(.top, 4)
        .padding(.horizontal, 40)
        .multilineTextAlignment(.center)
      Spacer()
      PrimaryButton(
        action: {
          viewContext.handle(.tapOnReloadCards)
        },
        text: "Try again",
        colorSheme: .blue
      )
      .padding(.horizontal, 40)
      .padding(.bottom, 40)
    }
    .transition(.opacity)
  }
  
  @ViewBuilder
  private var chooseSideButtonsView: some View {
    if isDetailsShown {
      VStack {
        Text("Do you agree with this?")
          .font(.sfPro(.bold, size: 18))
          .padding(.top, 30)
        HStack {
          PrimaryButton(action: {
            viewContext.handle(.tapOnStartBattle(against: false, topic: .random()))
          }, text: "Yes", colorSheme: .black)
          PrimaryButton(action: {
            viewContext.handle(.tapOnStartBattle(against: true, topic: .random()))
          }, text: "No", colorSheme: .black)
        }
      }
      .padding(EdgeInsets(top: 130, leading: 28, bottom: 40, trailing: 28))
      .transition(.move(edge: .bottom).combined(with: .opacity))
    }
  }

  private func calculateOffset(index: Int) -> CGFloat {
    guard index < 3 else { return 0 }
    return CGFloat(index) * 2.60
  }
}

struct DebateCardsView_Previews: PreviewProvider {
  
  static var previews: some View {
    DebateCardsView(viewContext: .preview(
      .content(DebateViewContent(questions: [
        .random(),
        .random(),
        .random(),
      
      
      ]))
    ))
  }
}

private enum ViewIdentifier: String {
  case card
  case title
  case subtitle
}
