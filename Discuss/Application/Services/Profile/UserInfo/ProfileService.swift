//
//  UserProfileService.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 07.05.2023.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import Combine

protocol HasProfileService: AnyObject {
  var profileService: IProfileService { get }
}

protocol IProfileService {
  func subscribeToUserInfo() -> (UUID, AnyPublisher<UserProfileInfo, Never>)
  func unsubscribeToUserInfo(uuid: UUID)
  func getUserInfo() async throws -> UserProfileInfo
  func saveUserInfo(_ info: UserProfileInfo) async throws -> Void
  func updateInfo<T>(keyPath: WritableKeyPath<UserProfileInfo, T>, newValue: T) async throws
  func appendSpeakingSession(_ session: SpeakingSession) async throws
}

enum ProfileError: Error {
  case noProfileExist
  case databaseError
}

@MainActor
final class ProfileService: IProfileService {
  private let collection = Firestore.firestore().collection("Users")
  private var listeners: [UUID: ListenerRegistration] = [:]
  private let services: Services
  
  init(services: Services) {
    self.services = services
  }
  
  func getUserInfo() async throws -> UserProfileInfo {
    guard let uid = services.authService.userUid else {
      throw ProfileError.noProfileExist
    }
    do {
      let profileInfo = try await collection.document(uid).getDocument(as: UserProfileInfo.self)
      return profileInfo
    } catch {
      throw ProfileError.databaseError
    }
  }
  
  func saveUserInfo(_ info: UserProfileInfo) async throws {
    guard let uid = services.authService.userUid else {
      throw UserError.noCurrentId
    }
    AnalyticsService.setUserInfo(info)
    try collection.document(uid).setData(from: info)
  }
  
  func appendSpeakingSession(_ session: SpeakingSession) async throws {
    var profileInfo = try await getUserInfo()
    profileInfo.speakingSessions.append(session)
    try await saveUserInfo(profileInfo)
  }

  func updateInfo<T>(keyPath: WritableKeyPath<UserProfileInfo, T>, newValue: T) async throws {
    var profileInfo = try await getUserInfo()
    profileInfo[keyPath: keyPath] = newValue
    try await saveUserInfo(profileInfo)
  }
  
  func subscribeToUserInfo() -> (UUID, AnyPublisher<UserProfileInfo, Never>) {
    let userInfoSubject = PassthroughSubject<UserProfileInfo, Never>()
    
    guard let uid = services.authService.userUid else {
      return (UUID(), userInfoSubject.eraseToAnyPublisher())
    }
    
    let listener = collection.document(uid).addSnapshotListener { snapshot, error in
      if let snapshot, let userInfo = try? snapshot.data(as: UserProfileInfo.self) {
        userInfoSubject.send(userInfo)
      } else {
//        assertionFailure()
      }
    }
    let uuid = UUID()
    listeners[uuid] = listener
    return (uuid, userInfoSubject.eraseToAnyPublisher())
  }
  
  func unsubscribeToUserInfo(uuid: UUID) {
    listeners[uuid] = nil
  }
}
