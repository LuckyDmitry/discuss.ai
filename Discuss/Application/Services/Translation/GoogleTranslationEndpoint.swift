//
//  YandexTranslationEndpoint.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 11.06.2023.
//

import Foundation

enum GoogleTranslationEndpoint: BaseRequest {
  case translate(text: String, source: String, target: String)
  
  var headers: [String : String]? {
    ["Content-Type": "application/json"]
  }
  
  var httpMethod: HTTPMethod {
    .post
  }
  
  var body: Data? {
    switch self {
    case let .translate(text, source, target):
      let request: [String : Encodable] = [
        "q": text,
        "source": source,
        "target": target
      ]
      let data = try? JSONSerialization.data(withJSONObject: request)
      return data
    }
  }
  
  var url: URL {
    URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyCKePJDLt08_9irXBaQtkbTI3JQwf2I9JI")!
  }
}
