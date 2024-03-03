import Foundation
import SwiftUI
import FirebaseStorage

let isPreviewRunning = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"

struct FirebaseImage: View {
  
  let storage = Storage.storage()
  let name: String
  let color: String
  
  @State
  private var realImage: Data?
  
  @State
  private var isLoadingStarted = false
  
  var body: some View {
    if isPreviewRunning {
      Asset.image.swiftUIImage
        .resizable()
    } else {
        content
    }
  }
  
  @ViewBuilder
  private var content: some View {
    ZStack {
      if let realImage, let image = UIImage(data: realImage) {
        Image(uiImage: image)
          .resizable()
      } else {
        Rectangle()
          .shimmering(active: true)
      }
    }.task {
      guard !isLoadingStarted else { return }
      isLoadingStarted = true
      do {
        let url = try await storage.reference().child(name).downloadURL()
        let (data, _) = try await URLSession.shared.data(from: url)
        realImage = data
      } catch {
        print(error)
      }
    }
  }
}
