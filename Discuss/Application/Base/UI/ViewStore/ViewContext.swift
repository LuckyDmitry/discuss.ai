import Foundation
import SwiftUI
import Combine

@MainActor
@dynamicMemberLookup
final class ViewContext<State: Equatable, Action>: ObservableObject {
  
  @Published
  private(set) var state: State
  
  private var viewModel: AnyBaseViewModel<State, Action>?
  private var cancellables = Set<AnyCancellable>()
  
  init<ViewModel: BaseViewModel>(
    viewModel: ViewModel
  ) where ViewModel.State == State, ViewModel.Action == Action {
    self.viewModel = AnyBaseViewModel(viewModel)
    self.state = viewModel.state.value
    
    viewModel
      .state
      .receive(on: DispatchQueue.main)
      .sink { [weak self] newState in
        self?.state = newState
      }
      .store(in: &cancellables)
  }
  
  private init(_ state: State, viewModel: AnyBaseViewModel<State, Action>?) {
    self.state = state
    self.viewModel = viewModel
  }
  
  fileprivate init(state: State) {
    self.state = state
    self.viewModel = nil
  }
  
  func handle(_ action: Action) {
    viewModel?.handle(action)
  }
  
  subscript<T>(dynamicMember member: KeyPath<State, T>) -> T {
    state[keyPath: member]
  }
}

extension ViewContext {
  static func preview(_ state: State) -> ViewContext<State, Action> {
    self.init(state: state)
  }
}

