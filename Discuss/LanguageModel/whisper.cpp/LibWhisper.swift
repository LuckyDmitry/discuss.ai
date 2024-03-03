import Foundation

enum WhisperError: Error {
  case couldNotInitializeContext
}

struct SpeechToken: Codable, Hashable {
  var word: String
  var probability: Double
}

// Meet Whisper C++ constraint: Don't access from more than one thread at a time.
final class WhisperContext {
  private var context: OpaquePointer
  
  let backQueue = DispatchQueue(label: "Back", qos: .userInteractive)
  
  init(context: OpaquePointer) {
    self.context = context
  }
  
  deinit {
    whisper_free(context)
  }
  
  func fullTranscribe(samples: [Float]) async {
    // Leave 2 processors free (i.e. the high-efficiency cores).
    await Task(priority: .high) {
      let maxThreads = max(1, min(8, cpuCount() - 2))
      print("Selecting \(maxThreads) threads")
      var params = whisper_full_default_params(WHISPER_SAMPLING_GREEDY)
      "en".withCString { en in
        // Adapted from whisper.objc
//        params.print_realtime = true
//        params.print_progress = true
//        params.print_timestamps = true
        params.print_special = false
        params.translate = false
        params.language = en
        params.n_threads = Int32(maxThreads)
        params.offset_ms = 0
        params.no_context = true
        params.single_segment = false
        params.token_timestamps = true
        
        whisper_reset_timings(self.context)
        print("About to run whisper_full")
        samples.withUnsafeBufferPointer { samples in
          if (whisper_full(self.context, params, samples.baseAddress, Int32(samples.count)) != 0) {
            print("Failed to run the model")
          } else {
            whisper_print_timings(self.context)
          }
        }
      }
    }.value
  }
  
  func getTranscription() async -> [SpeechToken] {
    await Task(priority: .userInitiated) {
      var transcription: [SpeechToken] = []
      let segments = whisper_full_n_segments(context)
      for segment in 0..<segments {
        let tokens = whisper_full_n_tokens(context, segment)
        for token in 0..<tokens {
          let p = whisper_full_get_token_p(context, segment, token)
          if let textSegment = whisper_full_get_token_text(context, segment, token) {
            transcription.append(.init(
              word: String.init(cString: textSegment),
              probability: Double(p)
            ))
          }
        }
      }
      return transcription
    }.value
  }
  
  static func createContext(path: String) throws -> WhisperContext {
    let context = whisper_init_from_file(path)
    if let context {
      return WhisperContext(context: context)
    } else {
      throw WhisperError.couldNotInitializeContext
    }
  }
}

fileprivate func cpuCount() -> Int {
  ProcessInfo.processInfo.processorCount
}
