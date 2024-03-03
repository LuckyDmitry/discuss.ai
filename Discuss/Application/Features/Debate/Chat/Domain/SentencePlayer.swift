import Foundation

actor SentencePlayer {
  
  typealias Services = HasSpeechSynthesizer & HasVoicePlayer
  
  private unowned let services: Services
  private var completion: (() -> Void)?
  
  private var onNewSentence: ((String) -> Void)?
  private var fragments: [Data?] = []
  private var currentIndex = 0
  private var sentences: [String] = []
  
  
  init(services: Services) {
    self.services = services
  }
  
  func start(sentences: [String], onNewSentence: @escaping @Sendable (String) -> Void, completion: @escaping () -> Void) {
    self.completion = completion
    self.onNewSentence = onNewSentence
    self.currentIndex = 0
    self.sentences = sentences
    fragments = Array(repeating: nil, count: sentences.count)
    internalFetch()
    fetchAllFragments()
  }
  
  func stop() {
    completion?()
    fragments.removeAll()
    sentences.removeAll()
    onNewSentence = nil
    completion = nil
  }
  
  private func internalFetch() {
    guard currentIndex != sentences.count - 1 else {
      completion?()
      return
    }
    Task {
      let currentElement = await waitForResponse()
      onNewSentence?(sentences[currentIndex])
      try self.services.voicePlayer.play(data: currentElement, onDidFinishPlaying: {
        self.currentIndex += 1
        self.internalFetch()
      })
    }
  }
  
  private func fetchAllFragments() {
    for (index, sentence) in sentences.enumerated() {
      Task {
        self.fragments[index] = try await services.speechSynthesizer.textToSpeech(sentence)
      }
    }
  }
  
  private func waitForResponse() async -> Data {
    (try? await Task {
      while true {
        if let fragment = self.fragments[currentIndex] {
          return fragment
        }
        try await Task.sleep(for: .milliseconds(30))
      }
    }.value) ?? Data()
  }
}
