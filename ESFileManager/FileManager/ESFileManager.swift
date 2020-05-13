//
//  ESFileManager.swift
//  ESFileManager
//
//  Created by Дмитрий Торопкин on 13.05.2020.
//  Copyright © 2020 Dmitriy Toropkin. All rights reserved.
//

import Foundation

// MARK: - ESFileManager

/// Manager for write and read file from bundle
struct ESFileManager {
    
   
    private var defaultFileInfo: ESFileModel
    private var defaultDirectory: ESFileManagerDirectory
    
    init(defaultFileInfo: ESFileModel, defaultDirectory: ESFileManagerDirectory) {
        self.defaultFileInfo = defaultFileInfo
        self.defaultDirectory = defaultDirectory
    }
    
    private func getDocumentsDirectory() -> URL {
        return URL(string: "")!
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0].appendingPathComponent(self.directoryPath.na)
    }
}

// MARK: ALFileManagerProtocol Impletation

extension ESFileManager: ESFileManagerProtocol {
    
    /// write data to disk
    /// - Parameters:
    ///   - data: data that need to be writed
    ///   - completion: completion block with optional Error
    func write(data: Data, completion: (Error?) -> Void) {
        do {
            try data.write(to: self.getDocumentsDirectory())
            completion(nil)
        } catch {
            completion(error)
        }
        
    }
    
    /// Read data from disk
    /// - Parameter completion: completion block with optional data from storage
    func read(completion: (Data?) -> Void) {
        completion(FileManager.default.contents(atPath: self.getDocumentsDirectory().path))
    }
    
    /// Remove log file from disk
    /// - Parameter completion: completion block with optional Error
    func clean(completion: (Error?) -> Void) {
        do {
            try FileManager().removeItem(at: self.getDocumentsDirectory())
            completion(nil)
        } catch {
            completion(error)
        }
        
    }
}
