//
//  ProfileViewModel.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 03.06.2023.
//

import Foundation
import Combine

@MainActor
final class ProfileViewModel {
  typealias State = ProfileState
  typealias Action = ProfileAction
  
  typealias Services = HasProfileService & HasAuthService
  
  var state: CurrentValueSubject<ProfileState, Never> = .init(ProfileState())
  
  // MARK: Private
  
  @Published
  private(set) var userInfo: UserProfileInfo = .placeholder
  
  private let services: Services
  private let router: ProfileRouter
  private let profileWorker: ProfileWorker
  private var cancellables = Set<AnyCancellable>()
  private var userUUIDPublisher: UUID?
  
  init(services: Services, router: ProfileRouter, profileWorker: ProfileWorker = ProfileWorker()) {
    self.services = services
    self.router = router
    self.profileWorker = profileWorker
  }
  
  deinit {
    if let userUUIDPublisher {
      services.profileService.unsubscribeToUserInfo(uuid: userUUIDPublisher)
    }
  }
}

// MARK: BaseViewModel

extension ProfileViewModel: BaseViewModel {
  
  func handle(_ action: ProfileAction) {
    switch action {
    case .viewAppeared:
      onAppear()
    case .settingsTap:
      onSettingsPressed()
    }
  }
}

// MARK: Logic

extension ProfileViewModel {
  private func onAppear() {
    let (uuid, userInfoPublisher) = services.profileService
      .subscribeToUserInfo()
    
    userInfoPublisher
      .receive(on: RunLoop.main)
      .sink { [weak self] updatedProfile in
        guard let self else { return }
        let longestStreak = profileWorker.calculateLongestStreak(sessions: updatedProfile.speakingSessions)
        let weekdaysStreak = profileWorker.calculateWeekdayStreak(
          registrationTime: 0,
          sessions: updatedProfile.speakingSessions
        )
        
        self.modify {
          $0.userInfo = .init(
            name: updatedProfile.name,
            points: updatedProfile.currentRating,
            longestStreak: longestStreak,
            wordsSpoken: updatedProfile.wordsSpoken,
            sentencesSpoken: updatedProfile.sentencesSpoken,
            weekdaysStreak: weekdaysStreak
          )
        }
      }
      .store(in: &cancellables)
    
    AnalyticsService.screenAppear(.profile)
    
    userUUIDPublisher = uuid
  }
  
  private func onSettingsPressed() {
    router.goToSettings()
  }
}

// MARK: Helpers

private extension ProfileViewModel {
  
  
}
