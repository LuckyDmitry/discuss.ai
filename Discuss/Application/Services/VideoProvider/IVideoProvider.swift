import Foundation

protocol HasVideoProvider {
  var videoProvider: IVideoProvider { get }
}

struct Video: Codable, Hashable, Identifiable {
  var movie: String
  var id: String
  var text: String
  var videoUrl: URL
  
  enum CodingKeys: String, CodingKey {
    case movie, id, text
    case videoUrl = "video-url"
  }
}

protocol IVideoProvider {
  func fetchVideo(_ videoUrl: URL) async throws -> Data
  func fetchVideoItems(_ query: VideoFeedDTO.Input) async throws -> VideoFeedDTO.Output
}
