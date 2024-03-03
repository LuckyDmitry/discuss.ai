import Foundation

enum HTTPMethod {
  case post, get
  
  var string: String {
    switch self {
    case .post:
      return "POST"
    case .get:
      return "GET"
    }
  }
}

protocol BaseRequest {
  var url: URL { get }
  var headers: [String: String]? { get }
  var httpMethod: HTTPMethod { get }
  var body: Data? { get }
  
  var request: URLRequest { get }
}

extension BaseRequest {
  var request: URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.string
    request.httpBody = body
    request.allHTTPHeaderFields = headers
    return request
  }
}
