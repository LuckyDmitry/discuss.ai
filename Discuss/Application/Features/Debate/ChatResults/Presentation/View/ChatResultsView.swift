import ActivityIndicatorView
import SwiftUI

struct ChatResultsView: View {
  
  @StateObject
  var viewContext: ViewContext<LoadableDataState<ChatResultsState>, ChatResultsAction>
  
  @State
  private var exitConfirmationAlertShown = false
  
  @State
  private var animating = false
  
  var body: some View {
    VStack(spacing: 0) {
//      headerView
      Spacer()
      switch viewContext.state {
      case .idle:
        EmptyView()
      case let .content(state):
        content(state)
      case .loading:
        ActivityIndicatorView(
          isVisible: .constant(true),
          type: .opacityDots(count: 3, inset: 3)
        )
          .foregroundColor(Colors.TextAndIcons.gray1.color)
          .frame(width: 50, height: 25)
          .frame(maxHeight: .infinity)
      case .error:
        VStack(spacing: 16) {
          Spacer()
          Asset.Chat.error.swiftUIImage
            .resizable()
            .frame(width: 100, height: 100)
          Text("Something broken")
            .font(.sfPro(.bold, size: 20))
          Text("Try again. If the problem persists, try again later. We are probably already trying to fix everything")
            .font(.sfPro(.regular, size: 16))
            .foregroundColor(Asset.Colors.TxtIcons.gray2.swiftUIColor)
            .multilineTextAlignment(.center)
          PrimaryButton(action: {
            viewContext.handle(.tapOnRetry)
          }, text: "Try again")
          Spacer()
        }
        .padding(.horizontal, 24)
      }
    }
    .padding(.horizontal)
    .padding(.top, 24)
    .onAppear {
      viewContext.handle(.viewAppeared)
    }
    .alert(
      "Do you want to exit the debate?",
      isPresented: $exitConfirmationAlertShown,
      actions: {
        Button(action: {
          exitConfirmationAlertShown = false
        }, label: {
          Text("Cancel")
        })
        Button(action: {
          viewContext.handle(.exitTapped)
        }, label: {
          Text("Exit")
        })
      })
    .toolbar(.hidden, for: .navigationBar)
  }
  
  private func content(_ state: ChatResultsState) -> some View {
    ZStack(alignment: .bottom) {
      VStack(spacing: 0) {
        ScrollView(showsIndicators: false) {
          starsView(state)
          Asset.Chat.drum.swiftUIImage
            .resizable()
            .frame(width: 100, height: 100)
          Text(title(state))
            .font(.sfPro(.bold, size: 24))
            .padding(.top, 30)
          Text(subtitle(state))
            .font(.sfPro(.regular, size: 14))
            .padding(.top, 4)
          HStack(spacing: 16) {
            ChatCongratulationsView(
              title: "words used",
              value: state.wordsUsed,
              colorSheme: .blue
            )
            ChatCongratulationsView(
              title: "key phrases",
              value: state.keyPhrases,
              colorSheme: .purple
            )
            ChatCongratulationsView(
              title: "score",
              value: state.score,
              colorSheme: .green
            )
          }
          .padding(.top, 45)
          ChatResultsCorrectionsView(
            suggests: state.vocabulary,
            mistakes: state.mistakes,
            motivationQuote: ""
          )
          .padding(.top, 80)
          Spacer()
        }
      }
      buttonsView(state)
    }
  }
      
  private func title(_ state: ChatResultsState) -> String {
    if state.round == 1 {
      return "You did it!"
    } else if state.round == 2 {
      return "You did it again!"
    } else {
      return "All 3 stars are yours!"
    }
  }
  
  private func subtitle(_ state: ChatResultsState) -> String  {
    if state.round != 3 {
      return "Will you get to the next star?"
    } else {
      return "Great job"
    }
  }
  
  @ViewBuilder
  private var headerView: some View {
    HStack {
      Button(action: {
        exitConfirmationAlertShown = true
      }, label: {
        Asset.Common.close.swiftUIImage
          .resizable()
          .renderingMode(.template)
          .foregroundColor(.white)
          .frame(width: 10, height: 10)
          .padding(5)
          .background(
            Circle()
              .fill(Asset.Colors.TxtIcons.gray2.swiftUIColor)
          )
      })
    }
    .frame(maxWidth: .infinity, alignment: .trailing)
  }
  
  
  @ViewBuilder
  private func starsView(_ state: ChatResultsState) ->  some View {
    HStack {
      makeStarView(roundCount: 1, state)
        .frame(maxHeight: .infinity, alignment: .bottomLeading)
      
      makeStarView(roundCount: 2, state)
        .frame(maxHeight: .infinity, alignment: .top)
      makeStarView(roundCount: 3, state)
        .frame(maxHeight: .infinity, alignment: .bottomTrailing)
    }
    .frame(height: 70)
    .onAppear {
      animating = true
    }
  }

  @ViewBuilder
  private func makeStarView(roundCount: Int, _ state: ChatResultsState) -> some View {
    ZStack {
      Asset.Chat.star.swiftUIImage
        .resizable()
        .frame(width: 40, height: 40)
      if animating && roundCount <= state.round  {
        Asset.Chat.filledStar.swiftUIImage
          .resizable()
          .frame(width: 40, height: 40)
          .transition(.opacity.animation(.discussInteractiveSring.delay(0.2 + Double(roundCount / 4))))
          .animation(.discussInteractiveSring, value: animating)
      }
    }
  }
  
  @ViewBuilder
  private func buttonsView(_ state: ChatResultsState) -> some View {
    PrimaryButton(
      action: {
        viewContext.handle(.finishButtonTapped)
      },
      text: "Finish"
    )
    .padding(.bottom, 20)
  }
}

struct ChatResultsView_Previews: PreviewProvider {
  static var previews: some View {
    ChatResultsView(viewContext: .preview(.error))
  }
}
