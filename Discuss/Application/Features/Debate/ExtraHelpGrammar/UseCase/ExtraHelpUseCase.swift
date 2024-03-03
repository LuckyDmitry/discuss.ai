import Foundation

final class ExtraHelpUseCase {
  
  typealias Services = HasTranslationService & HasProfileService
  
  // MARK: Private properties
  
  private let services: Services
  private let debate: DebateQuestion
  
  // MARK: Initialization
  
  init(services: Services, debate: DebateQuestion) {
    self.services = services
    self.debate = debate
  }
  
  // MARK: Internal methods
  
  func loadTranslation(_ message: String) async throws -> String {
    let userProfile = try await services.profileService.getUserInfo()
    return try await services.translationService.translate(
      text: message,
      originalLanguage: userProfile.learningLanguage,
      targetLanguge: userProfile.nativeLanguage
    )
  }
  
  func loadContent() -> DebateQuestion {
    return debate
  }
}
