//
//  ESFileManager.swift
//  ESFileManager
//
//  Created by Дмитрий Торопкин on 13.05.2020.
//  Copyright © 2020 Dmitriy Toropkin. All rights reserved.
//

import Foundation

enum testerror: Error {
    case test
}

// MARK: - ESFileManager

/// Manager for write and read file from bundle
public struct ESFileManager {
    
    private var defaultFileInfo: ESFileModel
    private var defaultDirectory: ESFileManagerDirectory
    
    public init(defaultFileInfo: ESFileModel, defaultDirectory: ESFileManagerDirectory = .applicationSupport(useBackups: false)) {
        self.defaultFileInfo = defaultFileInfo
        self.defaultDirectory = defaultDirectory
    }
    
    private func getDocumentsDirectory() throws -> (url: URL, useBackups: Bool) {
        
        var path: URL = FileManager.default.temporaryDirectory
        var _useBackups = false
        
        do {
            switch self.defaultDirectory {
            case .documents(urlPath: let urlPath, useBackups: let useBackups):
                path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                _useBackups = useBackups
                if let urlPath = urlPath {
                    fatalError("Пока что не работает")
                    path.appendPathComponent(urlPath)
                }
            case .applicationSupport(urlPath: let urlPath, useBackups: let useBackups):
                path = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                _useBackups = useBackups
                if let urlPath = urlPath {
                    fatalError("Пока что не работает")
                    path.appendPathComponent(urlPath)
                }
            case .caches(urlPath: let urlPath):
                path = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                if let urlPath = urlPath {
                    fatalError("Пока что не работает")
                    path.appendPathComponent(urlPath)
                }
            case .tmp:
                path = FileManager.default.temporaryDirectory
            }
        } catch {
            throw error
        }
        
        return (path.appendingPathComponent(self.defaultFileInfo.getFileName()), _useBackups)
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
            try data.write(to: self.getDocumentsDirectory().url)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    /// Read data from disk
    /// - Parameter completion: completion block with optional data from storage
    func read(completion: (Data?, Error?) -> Void) {
        do {
            let data = try FileManager.default.contents(atPath: self.getDocumentsDirectory().url.path)
            completion(data, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    /// Remove log file from disk
    /// - Parameter completion: completion block with optional Error
    func clean(completion: (Error?) -> Void) {
        do {
            try FileManager().removeItem(at: self.getDocumentsDirectory().url)
            completion(nil)
        } catch {
            completion(error)
        }
        
    }
}
