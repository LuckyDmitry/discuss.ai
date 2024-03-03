//
//  YandexTranslationService.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 11.06.2023.
//

import Foundation

private struct GoogleTranslationDTO: Decodable {
  struct Translation: Decodable {
    var translatedText: String
  }
  
  struct DataDTO: Decodable {
    var translations: [Translation]
  }
  
  var data: DataDTO
}

final class GoogleTranslationService: ITranslationService {
  typealias Services = HasNetworkService
  
  private let services: Services
  
  init(services: Services) {
    self.services = services
  }
  
  func translate(text: String, originalLanguage: Language, targetLanguge: Language) async throws -> String {
    do {
      let translation: GoogleTranslationDTO = try await services.networkService.makeRequest(GoogleTranslationEndpoint.translate(
        text: text,
        source: originalLanguage.rawValue,
        target: targetLanguge.rawValue
      ))
      
      guard let translationString = translation.data.translations.first?.translatedText else {
        throw NetworkError.requestFailed
      }
      return translationString
    } catch {
      print(error)
      throw NetworkError.requestFailed
    }
  }
}
