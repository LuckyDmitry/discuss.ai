//
//  ITranslationService.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 11.06.2023.
//

import Foundation

protocol HasTranslationService: AnyObject {
  var translationService: ITranslationService { get }
}

protocol ITranslationService {
  func translate(text: String, originalLanguage: Language, targetLanguge: Language) async throws -> String
}
