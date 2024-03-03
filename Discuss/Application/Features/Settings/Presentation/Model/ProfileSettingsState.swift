import Foundation

struct ProfileSettingsState: Equatable {
  var userInfo: UserProfileInfo?
  var userTouchEnabled = true
  var notificationTime = (0...24).map { $0 }
}
