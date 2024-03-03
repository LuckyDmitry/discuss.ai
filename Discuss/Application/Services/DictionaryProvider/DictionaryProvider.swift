//
//  DictionaryProvider.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 25.05.2023.
//

import Foundation

protocol HasDictionaryProvider {
  var dictionaryProvider: IDictionaryProvider { get }
}

protocol IDictionaryProvider {
  func requestExplanation(_ phrase: String) async throws -> String
  func requestTranslation(_ phrase: String) async throws -> String
}
