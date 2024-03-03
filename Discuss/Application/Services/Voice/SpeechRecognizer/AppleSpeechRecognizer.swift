import Foundation
import Speech
import AVFoundation

final class AppleSpeechRecognizer: ISpeechRecognizer {
  var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US")) // Change the locale as needed
  let audioEngine = AVAudioEngine()
  let audioSession = AVAudioSession.sharedInstance()
  private var recognitionTask: SFSpeechRecognitionTask?
  private var recognizedText: String = ""
  
  var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  
  func setupLanguage(_ language: Language) {
    speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: language.rawValue))
  }
  
  func startRecording(_ intermediateResults: ((String) -> Void)?) throws {
    audioEngine.inputNode.removeTap(onBus: 0)
    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
    recognitionRequest?.shouldReportPartialResults = true
    recognitionRequest?.taskHint = .unspecified
    recognitionRequest?.addsPunctuation = true
    recognizedText = ""
    try audioSession.setCategory(AVAudioSession.Category.record)
    try audioSession.setMode(AVAudioSession.Mode.measurement)
    try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    
    guard let recognitionRequest = recognitionRequest else {
      throw NSError(domain: "YourAppDomain", code: 0, userInfo: nil)
    }
    
    recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] result, error in
      if let result = result {
        // Process the recognized speech result
        let transcription = result.bestTranscription.formattedString
        self?.recognizedText = transcription
        intermediateResults?(transcription)
        print("Live transcription: \(transcription)")
      } else if let error = error {
        // Handle the error
        print("Error in speech recognition: \(error)")
      }
    }
    
    let audioInputNode = audioEngine.inputNode
    
    let recordingFormat = audioInputNode.outputFormat(forBus: 0)
    audioInputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
      recognitionRequest.append(buffer)
    }
    
    audioEngine.prepare()
    try audioEngine.start()
  }
  
  func stop() async throws -> String {
    
    audioEngine.stop()
    
    recognitionRequest?.endAudio()
    recognitionTask?.finish()
    recognitionTask = nil
    audioEngine.inputNode.removeTap(onBus: 0)
    return recognizedText
  }
  
  func requestSpeechRecognitionAuthorization() {
    SFSpeechRecognizer.requestAuthorization { authStatus in
      switch authStatus {
      case .authorized:
        print("Speech recognition authorized!")
      case .denied:
        print("Speech recognition denied.")
      case .restricted:
        print("Speech recognition restricted.")
      case .notDetermined:
        print("Speech recognition not determined.")
      @unknown default:
        print("Unknown speech recognition authorization status.")
      }
    }
  }
}
