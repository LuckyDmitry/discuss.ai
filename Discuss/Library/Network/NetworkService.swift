import Foundation
import Combine

final class NetworkService: INetworkService {
  private let session: URLSession
  
  init() {
    let configuration = URLSessionConfiguration.default
    session = URLSession(configuration: configuration)
  }
  
  func makeRequest<ResultType>(_ request: BaseRequest) async throws -> ResultType where ResultType : Decodable {
      let data = try await makeDataRequest(request)
      let decoder = JSONDecoder()
      let decodedType = try decoder.decode(ResultType.self, from: data)
      return decodedType
  }
  
  func makeDataRequest(_ request: BaseRequest) async throws -> Data {
    do {
      let urlRequest = request.request
      let (data, _) = try await session.data(for: urlRequest)
      return data
    } catch {
      print("NETWORK ERROR \(error.localizedDescription)")
      throw error
    }
  }
}
