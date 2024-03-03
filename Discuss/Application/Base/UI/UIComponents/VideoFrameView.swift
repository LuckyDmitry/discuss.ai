import AVFoundation
import AVKit
import SwiftUI

struct VideoFrameView: View {
    let videoURL: URL
    
    @State private var capturedImage: Image? = nil
    
    var body: some View {
        VStack {
            if let image = capturedImage {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView() // Show a loading indicator while capturing the frame
            }
        }
        .onAppear {
            captureFirstFrame(videoURL: videoURL) { image in
                DispatchQueue.main.async {
                    capturedImage = image.map(Image.init)
                }
            }
        }
    }
    
    private func captureFirstFrame(videoURL: URL, completion: @escaping (UIImage?) -> Void) {
        let asset = AVAsset(url: videoURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        let time = CMTimeMake(value: 0, timescale: 1) // Capture the first frame
        
        generator.generateCGImagesAsynchronously(forTimes: [NSValue(time: time)]) { requestedTime, image, _, _, error in
            if let error = error {
                print("Error capturing video frame: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let cgImage = image else {
                completion(nil)
                return
            }
            
            let uiImage = UIImage(cgImage: cgImage)
            completion(uiImage)
        }
    }
}
