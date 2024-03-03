import Foundation

typealias DebateViewState = LoadableDataState<DebateViewContent>

struct DebateViewContent: Equatable {
  var questions: [DebateQuestion]
}
