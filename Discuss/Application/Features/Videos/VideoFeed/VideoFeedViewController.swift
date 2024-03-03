////
////  VideoFeedViewController.swift
////  Elizabeth
////
////  Created by Trifonov Dmitriy Aleksandrovich on 26.05.2023.
////
//
//import Foundation
//import UIKit
//import SwiftUI
//
//enum Section {
//  case main
//}
//
//typealias DataSource = UICollectionViewDiffableDataSource<Section, Video>
//
//import UIKit
//
//class VideoFeedViewController: UIViewController {
//  private var dataSource: UICollectionViewDiffableDataSource<Section, Video>!
//  private let services: VideoServices
//  private var videos: [Video] = []
//  private lazy var collectionView: UICollectionView = {
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .vertical
//    layout.minimumLineSpacing = 0
//    layout.minimumInteritemSpacing = 0
//    
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//    collectionView.scrollIndicatorInsets = .zero
//    collectionView.translatesAutoresizingMaskIntoConstraints = false
//    collectionView.showsVerticalScrollIndicator = false
//    collectionView.isPagingEnabled = true
//    collectionView.delegate = self
//    return collectionView
//  }()
//  
//  private enum Section {
//    case main
//  }
//  
//  init(videos: VideoFeed, services: VideoServices) {
//    self.videos = videos.videos
//    self.services = services
//    super.init(nibName: nil, bundle: nil)
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//  
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    view.addSubview(collectionView)
//    
//    let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Video> { cell, indexPath, video in
//      cell.contentConfiguration = UIHostingConfiguration {
//        VideoFullVideoView(videoServices: self.services, video: video, onKnowTapped: {})
//      }
//    }
//    
//    dataSource = UICollectionViewDiffableDataSource<Section, Video>(collectionView: collectionView) {
//      collectionView, indexPath, item in
//      return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
//    }
//    
//    collectionView.dataSource = dataSource
//    
//    reloadData()
//    
//    NSLayoutConstraint.activate([
//      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//    ])
//  }
//  
//  private func reloadData() {
//    var snapshot = NSDiffableDataSourceSnapshot<Section, Video>()
//    snapshot.appendSections([.main])
//    
//    snapshot.appendItems(videos, toSection: .main)
//    
//    dataSource.apply(snapshot, animatingDifferences: false)
//  }
//}
//
//extension VideoFeedViewController: UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    // Return the desired size for your cells
//    return .init(width: collectionView.bounds.width, height: collectionView.bounds.height)
//  }
//}
