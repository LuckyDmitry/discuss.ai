import Foundation

protocol ChatInterceptor {
  func intercept(_ messages: [ChatUseMessage]) -> [ChatUseMessage]
}

