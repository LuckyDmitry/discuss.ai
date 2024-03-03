//
//  ILanguageCourseProvider.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 05.06.2023.
//

import Foundation
import Combine

protocol HasQuestionsProvider {
  var topicsProvider: IQuestionsProvider { get }
}

@MainActor
protocol IQuestionsProvider {
  func getQuestions(level: LanguageLevel, topic: DebateTopic) async throws -> [DebateQuestion]
}
