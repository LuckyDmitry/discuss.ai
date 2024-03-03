//
//  VideoMock.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 28.05.2023.
//

import Foundation

enum VideoMock {
  static let video = Video(
    movie: "",
    id: "",
    text: "and he was foolish, and he was in the wrong place at the wrong time!",
    videoUrl: .init(string: "https://www.playphrase.me/video/5b18337a8079eb4cd4a4bb9c/628d9affb071e78202f589c0.mp4")!
  )
  
  static func mocks() -> [Video] {
    [
      Video(
        movie: "12321321321",
        id: "12321321",
        text: "We're in the wrong place",
        videoUrl: .init(string: "https://www.playphrase.me/video/628d23d2e1c3e7477147cc56/62a14f0afdbae9fe9167b220.mp4")!
      ),
      Video(
        movie: "123e21312",
        id: "dwqew1321321312",
        text: "and he was foolish, and he was in the wrong place at the wrong time!",
        videoUrl: .init(string: "https://www.playphrase.me/video/5b18337a8079eb4cd4a4bb9c/628d9affb071e78202f589c0.mp4")!
      ),
      Video(
        movie: "123e213asd12",
        id: "dwqew13213121312",
        text: "i'm just a guy who lived",
        videoUrl: .init(string: "https://www.playphrase.me/video/5b1839b08079eb4cd4a57a0d/627d4d688fb96832e3304b1f.mp4")!
      )
    ]
  }
}
