import Foundation
import Combine

protocol HasNetworkService {
  var networkService: INetworkService { get }
}

protocol INetworkService {
  func makeRequest<ResultType: Decodable>(_ request: BaseRequest) async throws -> ResultType
  func makeDataRequest(_ request: BaseRequest) async throws -> Data 
}

enum NetworkError: Error {
  case requestFailed
  case tryAgainLater
  case speechNotLoaded
}
