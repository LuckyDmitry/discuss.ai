import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import Foundation
import Combine

public class VideoLoader {
    
    public static let shared = VideoLoader()
    public private(set) var text = "Hello, World!"
    let storage = Storage.storage()
    lazy var ref = storage.reference()
    
    let fr = Firestore.firestore()
    
    var tasks: [StorageUploadTask] = []
    
    var allStorages = Set<String>()
    
    var records = Set<String>()

    public init() {
//        Task {
//            self.allStorages = Set((try! await ref.child("English").listAll().items.map { $0.name }))
//            
//            self.records = Set(try! await fr.collection("English").getDocuments().documents.compactMap {
//                let movieID = $0.data()["movieID"] as? String
//                return movieID
//            })
//        }
    }
    
    public func loadVideo(videoId: String) -> AnyPublisher<Data, Error> {
        let path = storage.reference(withPath: "English/\(videoId)")
      print("LOAD \(videoId)")
        
        return Future { promise in
            path.getData(maxSize: 20 * 1024 * 1024, completion: { result in
                switch result {
                case .failure(let error):
                    promise(.failure(error))
                case .success(let succ):
                    promise(.success(succ))
                }
            })
        }.eraseToAnyPublisher()
    }
    
    public func uploadVideo(videoID: String, data: Data, completion: @escaping () -> Void) {
//        guard !self.allStorages.contains(videoID) else {
//            completion()
//            return
//        }
//
//        let videoRef = ref.child("English/\(videoID)")
//        let task = videoRef.putData(data) { (meta, error) in
////            completion()
//            self.allStorages.insert(videoID)
//            print("VIDEO LOADED")
//        }
//        tasks.append(task)
        
    }
    
    public func uploadData(videoId: String, params: [String: Any]) {
//        guard !self.records.contains(videoId) else { return }
//        fr.collection("English").document("\(videoId)").setData(params)
//        print("ENTRY ADDED")
//        self.records.insert(videoId)
    }
}
