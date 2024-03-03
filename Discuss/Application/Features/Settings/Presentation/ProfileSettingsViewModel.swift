//
//  ProfileSettingsViewModel.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 07.05.2023.
//

import Foundation
import Combine

@MainActor
final class ProfileSettingsViewModel: BaseViewModel {
  typealias State = ProfileSettingsState
  typealias Action = ProfileSettingsAction
  typealias Services = HasProfileService & HasAuthService

  let state: CurrentValueSubject<ProfileSettingsState, Never> = .init(.init())
  
  private let services: Services
  private let router: ProfileSettingsRouter
  private var cancellables = Set<AnyCancellable>()
  private var userUUIDSubscription: UUID?
  
  init(
    services: Services,
    router: ProfileSettingsRouter
  ) {
    self.services = services
    self.router = router
  }
  
  func handle(_ action: ProfileSettingsAction) {
    switch action {
    case .viewAppeared:
      onViewAppear()
    case .notificationTimeUpdate(let notificationsStatus):
      updateNotificationsDate(notificationsStatus)
    case .languageLevelUpdate(let languageLevel):
      updateLanguageLevel(languageLevel)
    case .tapLogout:
      handleLogout()
    case .tapBack:
      router.goBack()
    case let .nativeLanguageUpdate(native):
      break
    case let .targetLanguageUpdate(target):
      updateLearningLanguage(target)
    }
  }
  
  deinit {
    if let userUUIDSubscription {
      services.profileService.unsubscribeToUserInfo(uuid: userUUIDSubscription)
    }
  }
}

// MARK: Workers

private extension ProfileSettingsViewModel {
  func onViewAppear() {
    let (uuid, userInfoPublisher) = services.profileService
      .subscribeToUserInfo()
    
    userInfoPublisher
      .sink(receiveValue: { [weak self] profileInfo in
        self?.modify {
          $0.userInfo = profileInfo
        }
      })
      .store(in: &cancellables)
    
    AnalyticsService.screenAppear(.settings)
    userUUIDSubscription = uuid
  }
  
  func updateNotificationsDate(_ status: NotificationsStatus) {
    Task {
      let notificationStatusTime: Int?
      switch status {
      case .disable:
        notificationStatusTime = nil
      case .enable(let time):
        notificationStatusTime = time
      }
      try await services.profileService.updateInfo(keyPath: \.notificationTime, newValue: notificationStatusTime)
    }
  }
  
  func updateLearningLanguage(_ language: Language) {
    Task {
      try await services.profileService.updateInfo(keyPath: \.learningLanguage, newValue: language)
    }
  }
  
  func updateLanguageLevel(_ languageLevel: LanguageLevel) {
    Task {
      try await services.profileService.updateInfo(keyPath: \.languageLevel, newValue: languageLevel)
    }
  }
  
  func handleLogout() {
    AnalyticsService.event(.tapOnSignout)
    Task {
      do {
        modify {
          $0.userTouchEnabled = false
        }
        try await services.authService.signOut()
        router.goToAuth()
      } catch {
        
      }
    }
  }
}
