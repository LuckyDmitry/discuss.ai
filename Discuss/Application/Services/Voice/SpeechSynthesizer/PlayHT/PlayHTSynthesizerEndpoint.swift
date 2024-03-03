//
//  GoogleSpeechSynthesizerEndpoint.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 01.06.2023.
//

import Foundation

enum PlayHTSynthesizerEndpoint: BaseRequest {
  case recognize(String)
  
  var headers: [String : String]? {
    ["Authorization": "Bearer 0542f997d60548988efd22986cd4a169",
     "Content-type": "application/json",
     "X-User-Id": "sZzOi7hE1DYM5hgM29DmjRUza6v1",
     "accept": "application/json"
    ]
  }
  
  var httpMethod: HTTPMethod {
    .post
  }
  
  var body: Data? {
    switch self {
    case .recognize(let text):
      let request = [
        "text": text,
        "voice": "larry"
      ] as [String: Any]
      let data = try? JSONSerialization.data(withJSONObject: request)
      return data
    }
  }
  
  var url: URL {
    URL(string: "https://play.ht/api/v2/tts")!
  }
}
