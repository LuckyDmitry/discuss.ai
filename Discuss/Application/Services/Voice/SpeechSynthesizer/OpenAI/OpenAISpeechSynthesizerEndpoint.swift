//
//  GoogleSpeechSynthesizerEndpoint.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 01.06.2023.
//

import Foundation

enum OpenAISpeechSynthesizerEndpoint: BaseRequest {
  case recognize(String)
  
  var headers: [String : String]? {
    ["Authorization": "Bearer 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",
     "Content-type": "application/json"
    ]
  }
  
  var httpMethod: HTTPMethod {
    .post
  }
  
  var body: Data? {
    switch self {
    case .recognize(let text):
      let request = [
        "input": text,
        "voice": "onyx",
        "model": "tts-1-hd",
        "output": "flac"
      ] as [String: Any]
      let data = try? JSONSerialization.data(withJSONObject: request)
      return data
    }
  }
  
  var url: URL {
    URL(string: "https://api.openai.com/v1/audio/speech")!
  }
}
