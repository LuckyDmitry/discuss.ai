//
//  GoogleSpeechSynthesizerEndpoint.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 01.06.2023.
//

import Foundation

enum GoogleSpeechSynthesizerEndpoint: BaseRequest {
  case recognize(text: String)
  
  var headers: [String : String]? {
    ["Content-Type": "application/json"]
  }
  
  var httpMethod: HTTPMethod {
    .post
  }
  
  var body: Data? {
    switch self {
    case .recognize(let text):
      let request: [String : Encodable] = [
        "input": [
          "text": text
        ],
        "voice": [
          "languageCode":"en-US",
          "name":"en-US-Neural2-D",
        ],
        "audioConfig": [
          "audioEncoding": "MP3"
        ]
      ]
      let data = try? JSONSerialization.data(withJSONObject: request)
      return data
    }
  }
  
  var url: URL {
    URL(string: "https://texttospeech.googleapis.com/v1/text:synthesize?key=AIzaSyCKePJDLt08_9irXBaQtkbTI3JQwf2I9JI")!
  }
}
