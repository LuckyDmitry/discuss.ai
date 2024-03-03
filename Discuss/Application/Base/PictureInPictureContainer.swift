//
//  PictureInPictureContainer.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 24.06.2023.
//

import Foundation

import AVKit

class PiPViewController: UIViewController, AVPictureInPictureControllerDelegate {
  var pictureInPictureController: AVPictureInPictureController?
  
  private let content: UIViewController
  
  init(content: UIViewController) {
    self.content = content
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pictureInPictureController = AVPictureInPictureController(playerLayer: .init())
    pictureInPictureController?.delegate = self
  }
  
  func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
//    if let window = UIApplication.shared.windows.first {
//      window.addSubview(customView)
//      // use autoLayout
//      customView.snp.makeConstraints { (make) -> Void in
//        make.edges.equalToSuperview()
//      }
//    }
  }
  
  func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
    
  }
}
