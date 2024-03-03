//
//  LanguageCourse.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 05.06.2023.
//

import Foundation

struct DebateQuestion: Hashable {
  struct Vocabulary: Hashable {
    let word: String
    let meaning: String
  }

  let questionId: String
  let title: String
  let description: String
  let topic: DebateTopic
  let level: LanguageLevel
  let image: String
  let vocabulary: [Vocabulary]
  let color: String
}

extension DebateQuestion {
  
  static let titles = ["Mock questiong"]
  
  static func random(uuid: String = UUID().uuidString) -> Self {
    DebateQuestion(
      questionId: uuid,
      title: "Does social media negatively impact mental health?",
      description: "Examining the effects of social media on mental health",
      topic: .technology,
      level: .intermediate,
      image: "sa",
      vocabulary: [
        .init(word: "Negatively", meaning: "Having a harmful effect"),
        .init(word: "Mental health", meaning: "Emotional and psychological well-being"),
        .init(word: "Social media", meaning: "online platforms for sharing and communication")
      ],
      color: ["#FF0000", "#FFFF00"].randomElement()!
    )
  }
}
