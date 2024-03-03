import Foundation

//enum WhisperRequest: BaseRequest {
//  private struct WhisperDTO: Encodable {
//    var file: Data
//    let model: String = "whisper-1"
//  }
//  
//  private static let API_KEY = "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"
//  
//  case recognizeSpeech(Data)
//  
//  var request: URLRequest {
//    
//    let headers = [
//      "Authorization": "Bearer \(WhisperRequest.API_KEY)",
//      "Content-Type": "multipart/form-data"
//    ]
//    
//    let dataA: Data
//    switch self {
//    case .recognizeSpeech(let data):
//      dataA = data
//    }
//    
//    let url = URL(string: "https://api.openai.com/v1/audio/transcriptions")
//    
//    let boundary = "Boundary-\(UUID().uuidString)"
//    
//    let lineBreak = "\r\n"
//    
//    var request = URLRequest(url: url!)
//    request.httpMethod = "POST"
//    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//    request.setValue("Bearer \(WhisperRequest.API_KEY)", forHTTPHeaderField: "Authorization")
//    
//    var body = Data()
//    
//    body.append("--\(boundary + lineBreak)".data(using: .utf8)!)
//    body.append("Content-Disposition: form-data; name=\"model\"\(lineBreak + lineBreak)")
//    body.append("whisper-1\(lineBreak)")
//    
//    body.append("--\(boundary + lineBreak)")
//    body.append("Content-Disposition: form-data; name=\"file\"; filename=\"whistle.m4a\"\(lineBreak)")
//    body.append("Content-Type: audio/m4a\(lineBreak + lineBreak)")
//    body.append(dataA)
//    body.append(lineBreak)
//    body.append("--\(boundary)--\(lineBreak)")
//    
//    request.httpBody = body
//    
//    return request
//  }
//}
