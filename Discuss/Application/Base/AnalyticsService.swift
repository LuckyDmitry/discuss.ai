//
//  AnalyticsService.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 06/11/2023.
//

import FirebaseCore
import FirebaseAnalytics

final class AnalyticsService {
  
  enum ScreenKey: String {
    case login
    case profile
    case settings
    case cards
    case detailCards = "detail_cards"
    case chat
    case chatResults = "chat_results"
    case onboardingName = "onboarding_name"
    case onboardingNativeLanguage = "onboarding_native_language"
    case onboardingLanguageLevel = "onboarding_language_level"
    case onboardingLanguageGoal = "onboarding_language_goal"
    case onboardingLanguageMinutesPerDay = "onboarding_minutes_per_day"
    case onboardingLanguageTopics = "onboarding_topics"
    case onboardingFinish = "onboarding_finish"
  }
  
  enum UserEvent {
    case tapOnCard(_ question: String)
    case skipCard(_ question: String)
    case swipeBackCard(_ question: String)
    case tapOnOpposite(_ question: String)
    case tapOnSupport(_ question: String)
    case tapOnCloseDetailCard(_ questiong: String)
    case tapOnDebateTopic(_ topic: DebateTopic)
    case tapOnTranslation
    case tapOnMic
    case tapOnStopRecording(words: Int)
    case tapOnMicDuringBotSpeech(_ messageLenght: Int)
    case tapPlayMessage
    case tapOnCancelRecording
    case tapOnLogin
    case tapOnSignout
    case tapOnCloseChat(userMessages: Int, botMessages: Int)
    case tapOnCloseChatOnIntemediateResults(userMessages: Int, botMessages: Int, score: Int?, mistakes: Int?, suggests: Int?)
    case tapOnNextRoundChatOnIntemediateResults(userMessages: Int, botMessages: Int, score: Int?, mistakes: Int?, suggests: Int?)
    case onboardingEnteredName
    case onboardingChoseNativeLanguage(String)
    case onboardingChoseLanguageLevel(languageLevel: LanguageLevel)
    case onboardingChoseLanguageGoal(languageGoal: LanguageGoal)
    case onboardingChoseMinutesPerDay(minutes: Int)
    case onboardingChoseTopics(topics: [DebateTopic])
    
    
    var params: [String: Any]? {
      switch self {
      case let .tapOnCard(question),
        let .skipCard(question),
        let .swipeBackCard(question),
        let .tapOnOpposite(question),
        let .tapOnSupport(question),
        let .tapOnCloseDetailCard(question):
        return ["question": question]
      case .tapOnTranslation,
          .tapOnMic,
          .tapPlayMessage,
          .tapOnCancelRecording,
          .tapOnLogin,
          .onboardingEnteredName,
          .tapOnSignout:
        return nil
      case let .tapOnDebateTopic(topic):
        return ["debate_topic": topic.rawValue]
      case .tapOnMicDuringBotSpeech(let messageLength):
        return ["botMessage_lenght": messageLength]
      case .tapOnCloseChat(let userMessages, let botMessages):
        return ["user_messages_amount": userMessages, "bot_messages_amount": botMessages]
      case .tapOnCloseChatOnIntemediateResults(let userMessages, let botMessages, let score, let mistakes, let suggests),
          .tapOnNextRoundChatOnIntemediateResults(let userMessages, let botMessages, let score, let mistakes, let suggests):
        return ["user_messages_amount": userMessages, "bot_messages_amount": botMessages, "current_score": score as Any, "mistakes": mistakes as Any, "suggests": suggests as Any]
      case let .onboardingChoseLanguageLevel(languageLevel):
        return ["language_level": languageLevel.rawValue]
      case let .onboardingChoseLanguageGoal(languageGoal):
        return ["language_goal": languageGoal.rawValue]
      case let .onboardingChoseMinutesPerDay(minutes):
        return ["daily_practice_minutes": minutes]
      case let .onboardingChoseTopics(topics):
        return ["topics": topics.map { $0.rawValue }.joined(separator: ", ")]
      case let .onboardingChoseNativeLanguage(nativeLanguage):
        return ["nativeLanguage": nativeLanguage]
      case .tapOnStopRecording(words: let words):
        return ["words": words]
      }
    }
  
    var analyticsEvent: String {
      switch self {
      case .tapOnDebateTopic:
        return "tap_on_debate_topic"
      case .tapOnCard:
        return "tap_on_card"
      case .skipCard:
        return "skip_card"
      case .swipeBackCard:
        return "swipe_back_card"
      case .tapOnOpposite:
        return "tap_on_opposite"
      case .tapOnSupport:
        return "tap_on_support"
      case .tapOnTranslation:
        return "tap_on_translation"
      case .tapOnMic:
        return "tap_on_mic"
      case .tapOnMicDuringBotSpeech:
        return "tap_on_mic_during_bot_speech"
      case .tapPlayMessage:
        return "tap_on_play_message"
      case .tapOnCancelRecording:
        return "tap_on_cancel_recording"
      case .tapOnLogin:
        return "tap_on_login"
      case .tapOnSignout:
        return "tap_on_sign_out"
      case .onboardingEnteredName:
        return "onboarding_entered_name"
      case .onboardingChoseNativeLanguage:
        return "onboarding_chose_language_level"
      case .onboardingChoseLanguageLevel:
        return "onboarding_chose_language_level"
      case .onboardingChoseLanguageGoal:
        return "onboarding_chose_language_goal"
      case .onboardingChoseMinutesPerDay:
        return "onboarding_chose_minutes_per_day"
      case .onboardingChoseTopics:
        return "onboarding_chose_topics"
      case .tapOnCloseChat:
        return "tap_on_close_chat"
      case .tapOnCloseChatOnIntemediateResults:
        return "tap_on_close_chat_on_intermediate_results"
      case .tapOnNextRoundChatOnIntemediateResults:
        return "tap_on_next_round_on_intermediate_results"
      case .tapOnCloseDetailCard:
        return "tap_on_close_detail_card"
      case .tapOnStopRecording:
        return "tap_on_stop_recording"
      }
    }
  }
  
  static func screenAppear(_ screenKey: ScreenKey) {
    Analytics.logEvent(screenKey.rawValue + "_opened", parameters: nil)
  }
  
  static func event(_ event: UserEvent) {
    Analytics.logEvent(event.analyticsEvent, parameters: event.params)
  }
  
  static func setUserParam(_ key: String, value: String) {
    Analytics.setUserProperty(value, forName: key)
  }
  
  static func setUserInfo(_ userInfo: UserProfileInfo) {
    Analytics.setUserProperty(userInfo.name, forName: "name")
    Analytics.setUserProperty(userInfo.nativeLanguage.rawValue, forName: "native_language")
    Analytics.setUserProperty(userInfo.userGoal.rawValue, forName: "user_goal")
    Analytics.setUserProperty(userInfo.languageLevel.rawValue, forName: "language_level")
    Analytics.setUserProperty("\(userInfo.practicePerDay.duration)", forName: "practice_per_day")
    Analytics.setUserProperty(userInfo.userTopics.map{ $0.rawValue }.joined(separator: ", "), forName: "topics")
  }
  
  static func setUserID(_ id: String) {
    Analytics.setUserID(id)
  }
}
