import Foundation

struct UserProfileInfo: Codable, Equatable {
  var name: String
  var nativeLanguage: Language
  var learningLanguage: Language
  var languageLevel: LanguageLevel
  var userGoal: LanguageGoal
  var userTopics: [DebateTopic]
  var practicePerDay: UserSettingPracticePerDay
  
  var currentRating: Int = 0
  var speakingSessions: [SpeakingSession] = []
  var sentencesSpoken: Int = 0
  var wordsSpoken: Int = 0

  var notificationTime: Int? = nil
}

extension UserProfileInfo {
  static let placeholder = UserProfileInfo(
    name: "Placeholder",
    nativeLanguage: .ru,
    learningLanguage: .en,
    languageLevel: .advanced,
    userGoal: .examPreparation,
    userTopics: [],
    practicePerDay: .casual
  )
  
  var isPlaceholder: Bool {
    self == Self.placeholder
  }
}
