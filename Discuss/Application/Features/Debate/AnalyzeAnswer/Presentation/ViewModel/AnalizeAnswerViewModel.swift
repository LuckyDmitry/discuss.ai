import Combine
import Foundation

final class AnalizeAnswerViewModel: BaseViewModel {
  typealias State = AnalizeAnswerState
  typealias Action = AnalizeAnswerAction
  
  // MARK: Private properties
  
  private(set) var state = CurrentValueSubject<State, Never>(
    AnalizeAnswerState(mistakes: nil)
  )
  
  private let router: AnalizeAnswerRouter
  private let useCase: AnalizeAnswerUseCaseProtocol
  
  // MARK: Initialization
  
  init(
    router: AnalizeAnswerRouter,
    useCase: AnalizeAnswerUseCaseProtocol
  ) {
    self.router = router
    self.useCase = useCase
  }
  
  // MARK: Internal
  
  func handle(_ action: Action) {
    Task {
      switch action {
      case .onAppear:
        await requestExplanation()
//        router.showDetailMistake(mistake)
      case .okayTapped:
        break
      }
    }
  }
}

extension AnalizeAnswerViewModel {
  
  private func requestExplanation() async {
    do {
      let explanation = try await useCase.requestExplanation()
      modify {
        $0.mistakes = explanation.mistakes
      }
    } catch {
      print("ERROR")
    }
  }
}
