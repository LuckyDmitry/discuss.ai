//
//  Storage.swift
//  TikTok
//
//  Created by Trifonov Dmitriy Aleksandrovich on 19.02.2023.
//  Copyright © 2023 Osaretin Uyigue. All rights reserved.
//

import Foundation
import Combine

enum Result<Value, Error> {
    case success(Value)
    case failure(Error?)
}

protocol Store {
    func save(_ data: Data) throws
    func get() -> Data?
    func remove(_ data: Data) throws
}

final class FileStore: Store {
    var path: URL
    
    init(path: URL) {
        self.path = path
    }
    
    func save(_ data: Data) throws {
        try data.write(to: path, options: .atomic)
    }
    
    func get() -> Data? {
        FileManager.default.contents(atPath: path.absoluteString)
    }
    
    func remove(_ data: Data) throws {
        try FileManager.default.removeItem(at: path)
    }
}
