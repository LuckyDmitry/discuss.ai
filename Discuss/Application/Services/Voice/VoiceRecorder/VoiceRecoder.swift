import Foundation
import AVFoundation

final class VoiceRecoder: IVoiceRecorder {
  private var recorder: AVAudioRecorder?
  private var recordingURL: URL?
  private(set) var isRecording = false
  
  enum RecorderError: Error {
    case couldNotStartRecording
    case couldNotSaveRecording
  }
  
  func startRecording() throws {
    let url = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      .appending(path: "recordedVoice.wav")
    
    let recordSettings: [String : Any] = [
      AVFormatIDKey: Int(kAudioFormatLinearPCM),
      AVSampleRateKey: 16000.0,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    
    let session = AVAudioSession.sharedInstance()
    try session.setCategory(.playAndRecord, mode: .default)
    let recorder = try AVAudioRecorder(url: url, settings: recordSettings)
    
    if recorder.record() == false {
      throw RecorderError.couldNotStartRecording
    }
    isRecording = true
    self.recordingURL = url
    self.recorder = recorder
  }
  
  func stopRecording() throws -> URL {
    recorder?.stop()
    recorder = nil
    isRecording = false
    guard let recordingURL else {
      throw RecorderError.couldNotSaveRecording
    }
    return recordingURL
  }
  
  private func requestRecordPermission(response: @escaping (Bool) -> Void) {
    AVAudioSession.sharedInstance().requestRecordPermission { granted in
      response(granted)
    }
  }
}
