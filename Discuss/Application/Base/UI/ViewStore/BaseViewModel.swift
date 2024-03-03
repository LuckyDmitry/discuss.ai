import Combine

@MainActor
protocol BaseViewModel {
    associatedtype State: Equatable
    associatedtype Action

    var state: CurrentValueSubject<State, Never> { get }

    func handle(_ action: Action)
}

struct AnyBaseViewModel<State: Equatable, Action>: BaseViewModel {
    var state: CurrentValueSubject<State, Never>
    private let handleAction: (Action) -> Void

    init<ViewModel: BaseViewModel>(_ viewModel: ViewModel) where ViewModel.State == State, ViewModel.Action == Action {
        self.state = viewModel.state
        self.handleAction = viewModel.handle
    }

    func handle(_ action: Action) {
        handleAction(action)
    }
}

extension BaseViewModel {
    func modify(_ modifier: (inout State) -> Void) {
        var stateBefore = state.value
        modifier(&stateBefore)
        state.send(stateBefore)
    }
  
  var value: State {
    state.value
  }
}
