import SwiftUI

struct ChangeTopicView: View {
  
  @State
  var currentTopic: DebateTopic
  var onChooseTopic: (DebateTopic) -> Void
  
  var body: some View {
    ChangePreferenceViewView(
      title: "Choose topic for debate",
      subtitle: "You can improve your messages according to your level. For example, an advanced level allows you to use idioms",
      preferences: DebateTopic.allCases,
      onChoosePreference: onChooseTopic,
      currentPreference: currentTopic
    )
  }
}

struct ChangeTopicView_Previews: PreviewProvider {
  static var previews: some View {
    ChangeTopicView(
      currentTopic: .technology,
      onChooseTopic: { _ in }
    )
  }
}
