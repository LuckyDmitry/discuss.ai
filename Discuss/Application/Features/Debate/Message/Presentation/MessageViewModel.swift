import Foundation
import Combine

final class MessageViewModel: BaseViewModel {

  typealias State = MessageViewState
  typealias Action = MessageViewAction
  
  let state: CurrentValueSubject<State, Never>
  
  private let useCase: MessageUseCase
  private var cancellables = Set<AnyCancellable>()
  
  init(
    isBotMessage: Bool,
    message: String
  ) {
    self.useCase = MessageUseCase(message: message)
    self.state = .init(MessageViewState(isBotMessage: isBotMessage, message: message))
    useCase.currentMessagePlaying
      .receive(on: DispatchQueue.main)
      .sink { [weak self] isPlaying in
        self?.modify { $0.isPlaying = isPlaying }
      }
      .store(in: &cancellables)
  }
  
  func handle(_ action: MessageViewAction) {
    Task {
      switch action {
      case .messageAppeared:
        if !value.isBotMessage {
          modify { $0.feedBackState = .loading }
          let response = try await useCase.improvmentsForMessage(value.message)
          
          let (improvments, areThereMistakes) = processResponse(response)
          
          modify { $0.feedBackState = .content(.init(
            improvments: improvments,
            areThereMistakes: areThereMistakes ?? false
          ))
           }
        } else {
          try await useCase.playingMessage(value.message)
        }
      case .tapOnImprovments:
        modify { $0.feedBackState.update { $0.isImprovmentsShown.toggle() } }
      case .tapOnPlayingMessage:
        if value.isPlaying {
          try await useCase.stopPlayingMessage()
        } else {
          try await useCase.playingMessage(value.message)
        }
      case .tapOnTranslatingMessage:
        guard !value.translationState.isContent else {
          modify { $0.translationState = .idle }
          return
        }
      
        modify { $0.translationState = .loading }
        let translation = try await useCase.translateMessage(value.message)
        modify { $0.translationState = .content(.init(translation: translation)) }
      }
    }
  }
  
  private func processResponse(_ response: String) -> (message: String, areThereMistakes: Bool?) {
      var areThereMistakes: Bool? = nil
      var lines = response.components(separatedBy: .newlines)

      // Iterate over the lines to find and process 'AreThereMistakes'
      for (index, line) in lines.enumerated() {
          if line.contains("AreThereMistakes:") {
              let components = line.split(separator: ":")
              if components.count == 2 {
                  let value = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
                  areThereMistakes = value.lowercased() == "\"true\""
              }

              // Remove the 'AreThereMistakes' line from the message
              lines.remove(at: index)
              break
          }
      }

      // Reconstruct the message without the 'AreThereMistakes' line
      let newMessage = lines.joined(separator: "\n")
      return (newMessage, areThereMistakes)
  }
}
