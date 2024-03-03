import Foundation

enum DebateViewAction {
  case onAppear
  case viewDisplayChanged(detailed: Bool)
  case tapOnClose
  case tapOnHint
  case tapOnLanguageLevel
  case topOnFilter
  case tapOnCard
  case tapOnReloadCards
  case tapOnCloseDetailCard
  case tapOnStartBattle(against: Bool, topic: DebateQuestion)
  case languageLevelChosen(LanguageLevel)
  case topicChosen(DebateTopic)
}
