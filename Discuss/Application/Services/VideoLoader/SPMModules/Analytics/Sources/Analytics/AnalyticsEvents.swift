//
//  File.swift
//  
//
//  Created by Trifonov Dmitriy Aleksandrovich on 02.04.2023.
//

import Foundation

public enum PredefinedEvent {
  case screenOpen(String)
  case screenClose(String)
  case error(Error)
}

public extension Telemetry {
  func predefined(_ event: PredefinedEvent) {
    switch event {
    case .screenOpen(let screenName):
      self.log(Event(name: "ScreenOpen", parameters: [
        "name": screenName
      ]))
    case .screenClose(let screenName):
      self.log(Event(name: "ScreenClose", parameters: [
        "name": screenName
      ]))
    case .error(let error):
      self.log(Event(name: "Error", parameters: [
        "description": error.localizedDescription
      ]))
    }
  }
}
