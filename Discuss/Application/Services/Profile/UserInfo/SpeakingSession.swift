import Foundation

struct SpeakingSession: Codable, Equatable {
  var topicId: String
  var score: Int?
  var startGMT: TimeInterval
  var duration: TimeInterval
}
