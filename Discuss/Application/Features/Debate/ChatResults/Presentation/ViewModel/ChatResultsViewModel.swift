import Foundation
import Combine

final class ChatResultsViewModel: BaseViewModel {
  typealias State = LoadableDataState<ChatResultsState>
  typealias Action = ChatResultsAction
  var state: CurrentValueSubject<State, Never>
  
  private let useCase: ChatResultsUseCase
  private let router: ChatResultsRouter
  private let debateQuestion: DebateQuestion
  private let messages: [ChatIntermediateMessage]
  
  init(
    messages: [ChatIntermediateMessage],
    debateQuestion: DebateQuestion,
    router: ChatResultsRouter,
    useCase: ChatResultsUseCase
  ) {
    self.router = router
    self.messages = messages
    self.debateQuestion = debateQuestion
    self.useCase = useCase
    state = .init(.loading)
  }
  
  func handle(_ action: ChatResultsAction) {
    Task {
      switch action {
      case .exitTapped:
        AnalyticsService.event(.tapOnCloseChatOnIntemediateResults(
          userMessages: messages.count,
          botMessages: messages.count,
          score: state.value.content?.score,
          mistakes: state.value.content?.mistakes.count,
          suggests: state.value.content?.vocabulary.count
        ))
        router.exitDebate()
      case .finishButtonTapped:
        break
//        if messages.filter { $0.isUser }.count == 3 {
//          router.exitDebate()
//        } else {
//          router.goToNextRound()
//          AnalyticsService.event(.tapOnNextRoundChatOnIntemediateResults(
//            userMessages: 3,
//            botMessages: 3,
//            score: state.value.content?.score,
//            mistakes: state.value.content?.mistakes.count,
//            suggests: state.value.content?.vocabulary.count
//          ))
//        }
      case .analyzeAnswersTapped:
        break
//        guard let lastMessage = messages.last else  { return }
//        router.analyzeMessages(debateQuestion, message: lastMessage)
      case .viewAppeared:
        AnalyticsService.screenAppear(.chatResults)
        await loadIntermediateResults()
      case .tapOnRetry:
        await loadIntermediateResults()
      }
    }
  }
  
  private func loadIntermediateResults() async {
    do {
      modify {
        $0 = .loading
      }
      let userMessages = messages.filter { $0.isUser }.map { $0.message }
      let results = try await self.useCase.getIntermediateResults(userMessages)
//      let userMessages = messages.filter { $0.isUser }.count
      modify {
        $0 = .content(.init(
          round: 2,
          isFinishScreen: false,
          keyPhrases: results.keyPhrases,
          wordsUsed: results.wordsUsed,
          score: results.score,
          mistakes: results.mistakes.map {
            .init(title: "\($0.mistake) -> \($0.corrected)", description: $0.explanation)
          },
          vocabulary: results.vocabulary.map {
            .init(title: "\($0.originalWord) -> \($0.suggestedWord)", description: $0.explanation)
          }
        ))
      }
    } catch {
      print(error)
      modify {
        $0 = .error
      }
    }
  }
}
