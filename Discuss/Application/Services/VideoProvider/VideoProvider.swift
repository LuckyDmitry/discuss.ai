//
//  VideoProvider.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 20.05.2023.
//

import Foundation

final class VideoProvider: IVideoProvider {
  private let network: INetworkService
  
  init(network: INetworkService) {
    self.network = network
  }
  
  func fetchVideo(_ videoURL: URL) async throws -> Data {
    fatalError()
//    try await network.loadData(videoURL)
  }
                               
  func fetchVideoItems(_ query: VideoFeedDTO.Input) async throws -> VideoFeedDTO.Output {
    try await network.makeRequest(PhraseMeRequest.search(input: query))
  }
}

struct PhraseContainer: Decodable {
  var phrases: [Phrase]
}

struct Phrase: Decodable {
  var text: String
}

struct VideoFeedDTO {
  struct Input: Encodable {
    var words: [String]
  }
  
  struct Output: Decodable {
    let phrases: [Video]
    
    @DefaultEmptyLossyArray
    var wordSuggestions: [String]
    @DefaultEmptyLossyArray
    var nextWordSuggestions: [String]
    
    enum CodingKeys: String, CodingKey {
      case wordSuggestions = "word-suggestions"
      case phrases
      case nextWordSuggestions = "next-word-suggestions"
    }
  }
}
