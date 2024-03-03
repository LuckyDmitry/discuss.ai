import Foundation

enum ProfileSettingsAction {
  case viewAppeared
  case notificationTimeUpdate(NotificationsStatus)
  case languageLevelUpdate(LanguageLevel)
  case nativeLanguageUpdate(Language)
  case targetLanguageUpdate(Language)
  case tapLogout
  case tapBack
}
