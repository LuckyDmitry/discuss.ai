import Foundation

private let endPoint = "https://www.playphrase.me/api/v1/phrases/search?skip=0&platform=native-ios&q="

enum PhraseMeRequest: BaseRequest {
  private struct PhraseMeInput: Encodable {
    var limit: Int = 5000
    var platform: String = "native-ios"
    var q: String
  }
  
  var url: URL {
    fatalError()
  }
  
  var headers: [String : String]? {
    [
      "X-Csrf-Token" : "Mfy4OyTi+f3cFJLbDhtbt2EmaTVkMXnpm8UBVgQNPx6LcEpYz4SgeBxgJiwtOAinaJpWZpP1jtIZ6vah"
    ]
  }
  
  var httpMethod: HTTPMethod {
    switch self {
    case .search:
      return .get
    }
  }
  
  var body: Data? {
    return nil
  }
  
  case search(input: VideoFeedDTO.Input)
  
  var request: URLRequest {
    var urlComponents = URLComponents()

    urlComponents.scheme = "https"
    urlComponents.host = "www.playphrase.me"
    urlComponents.path = "/api/v1/phrases/search"
    
    switch self {
    case .search(let input):
      let encoded = input.words.joined(separator: " ")
      urlComponents.queryItems = [
        .init(name: "limit", value: "5000"),
        .init(name: "platform", value: "native-ios"),
        .init(name: "q", value: encoded)
      ]
    }
    
    guard let urlString = urlComponents.string,
          let url = URL(string: urlString) else {
      fatalError()
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.string
    request.allHTTPHeaderFields = headers
    return request
  }
}
