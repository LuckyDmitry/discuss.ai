//
//  LanguageCourse.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.06.2023.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseStorage

private struct TopicDTO: Decodable {
  let questionId: String
  let image: String
  let topic: DebateTopic
  let level: LanguageLevel
  let color: String
}

private struct QuestionSpecificLanguageDTO: Decodable {
  struct VocabularyDTO: Decodable {
    let word: String
    let meaning: String
  }

  let description: String
  let vocabulary: [VocabularyDTO]
  let title: String
  let questionId: String
}

@MainActor
final class TopicsProvider: IQuestionsProvider {
  
  private let collection = Firestore.firestore().collection("Topics")
  private let storage = Storage.storage().reference()
  private let services: Services
  
  init(services: Services) {
    self.services = services
  }
  
  func getQuestions(level: LanguageLevel, topic: DebateTopic) async throws -> [DebateQuestion] {
    let userInfo = try await services.profileService.getUserInfo() 
    let learnningLanguage = userInfo.learningLanguage
    
    do {
      
      let topics = try await collection
//        .whereField("level", isEqualTo: level.rawValue)
//        .whereField("topic", isEqualTo: topic.rawValue)
        .getDocuments()
        .documents
        .compactMap {
          do {
            return try $0.data(as: TopicDTO.self)
          } catch {
            print($0)
            return nil
          }
        }
      guard !topics.isEmpty else {
        return []
      }
      
      let topicsDictionary: [String: TopicDTO] = topics.reduce(into: [:]) { dict, next in
        dict[next.questionId] = next
      }
      
      let questionsDatabase = mapLearningLanguageOnDatabase(learnningLanguage.rawValue)
      let questions = try await questionsDatabase
        .whereField("questionId", in: topics.map { $0.questionId })
        .getDocuments()
        .documents
        .map {
          try $0.data(as: QuestionSpecificLanguageDTO.self)
        }
      
      return questions.compactMap { (question: QuestionSpecificLanguageDTO) -> DebateQuestion? in
        guard let info = topicsDictionary[question.questionId] else { return nil }
        return .init(
          questionId: question.questionId,
          title: question.title,
          description: question.description,
          topic: info.topic,
          level: info.level,
          image: info.image,
          vocabulary: question.vocabulary.map { .init(word: $0.word, meaning: $0.meaning)},
          color: info.color
        )
      }
    } catch {
      print(error)
      throw error
    }
  }
  
  private func mapLearningLanguageOnDatabase(_ language: String) -> CollectionReference {
    return Firestore.firestore().collection(language)
  }
}

