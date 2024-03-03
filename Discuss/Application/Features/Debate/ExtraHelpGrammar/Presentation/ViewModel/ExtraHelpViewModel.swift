import Combine
import Foundation

final class ExtraHelpViewModel: BaseViewModel {
  typealias State = ExtraHelpState
  typealias Action = ExtraHelpAction
  
  // MARK: Private properties
  
  private(set) var state = CurrentValueSubject<State, Never>(
    ExtraHelpState(vocabulary: [])
  )

  private let router: ExtraHelpRouter
  private let useCase: ExtraHelpUseCase

  // MARK: Initialization
  
  init(
    router: ExtraHelpRouter,
    useCase: ExtraHelpUseCase
  ) {
    self.router = router
    self.useCase = useCase
  }
  
  // MARK: Internal
  
  func handle(_ action: Action) {
    Task {
      switch action {
      case .tapOnClose:
        router.onOkay()
      case .viewAppeared:
        await viewAppeared()
      case let .tapOnTranslation(translate):
        await loadTranslation(translate)
      }
    }
  }
}

extension ExtraHelpViewModel {
  private func viewAppeared() async {
    let content = useCase.loadContent()
    modify {
      $0.vocabulary = content.vocabulary.map { .init(original: .init(word: $0.word, meaning: $0.meaning))}
    }
  }
  
  private func loadTranslation(_ content: ExtraHelpState.Content) async {
    guard content.translation == .idle else {
      updateTranslationStatus(.idle, content: content)
      return
    }
    do {
      updateTranslationStatus(.loading, content: content)
      async let wordTask = useCase.loadTranslation(content.original.word)
      async let meaningTask = useCase.loadTranslation(content.original.meaning)
      let (word, meaning) = try await (wordTask, meaningTask)
      updateTranslationStatus(.loaded(.init(word: word, meaning: meaning)), content: content)
    } catch {
      print(error)
    }
  }
  
  private func updateTranslationStatus(_ status: ExtraHelpState.Content.Translation, content: ExtraHelpState.Content) {
    modify {
      if let index = $0.vocabulary.firstIndex(where: { $0.original.word == content.original.word }) {
        $0.vocabulary[index] = .init(translation: status, original: content.original)
      }
    }
  }
}
