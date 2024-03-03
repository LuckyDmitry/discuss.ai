//
//  VideoProviderMock.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 25.05.2023.
//

import Foundation
import Combine

final class VideoProviderMock: IVideoProvider {
  func fetchVideo(_ videoUrl: URL) async throws -> Data {
    return Data()
  }
  
  func fetchVideoItems(_ query: VideoFeedDTO.Input) async throws -> VideoFeedDTO.Output {
    return .init(phrases: [], wordSuggestions: [], nextWordSuggestions: [])
  }
}

final class DictionaryProviderMock: IDictionaryProvider {
  func requestExplanation(_ phrase: String) async throws -> String {
    return phrase
  }
  
  func requestTranslation(_ phrase: String) async throws -> String {
    return phrase
  }
}
