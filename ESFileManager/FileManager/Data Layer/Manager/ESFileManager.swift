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
public struct ESFileManager {
    
    private var defaultDirectory: ESFileManagerDirectory
    
    public init(defaultDirectory: ESFileManagerDirectory = .applicationSupport(useBackups: false)) {
        self.defaultDirectory = defaultDirectory
    }
    
    private func getDocumentsDirectory(fileName: String?, at directory: ESFileManagerDirectory? = nil) throws -> (url: URL, urlWithFileName: URL, useBackups: Bool) {
        
        var path: URL = FileManager.default.temporaryDirectory
        var _useBackups = false
        let _directory = directory != nil ? directory! : self.defaultDirectory
        
        do {
            switch _directory {
            case .documents(useBackups: let useBackups):
                path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                _useBackups = useBackups
            case .applicationSupport(useBackups: let useBackups):
                path = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                _useBackups = useBackups
            case .caches:
                path = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            case .tmp:
                path = FileManager.default.temporaryDirectory
            }
        } catch {
            throw error
        }
    
        var pathWithFileName = path
        if let file = fileName {
            pathWithFileName.appendPathComponent(file)
        }
        
        return (path, pathWithFileName, _useBackups)
    }
    
    
    private func _write(file: ESFileModel, at directory: ESFileManagerDirectory? = nil, completion: (Error?) -> Void) {
        do {
            guard let data = file.data else {
                completion(nil)
                return
            }
            if let _directory = directory {
                let directory = try self.getDocumentsDirectory(fileName: file.storage.getFileName(), at: _directory)
                
                if !FileManager.default.fileExists(atPath: directory.url.absoluteString) {
                    try FileManager.default.createDirectory(atPath: directory.url.absoluteString, withIntermediateDirectories: true, attributes: nil)
                }
                try data.write(to: directory.urlWithFileName)
            } else {
                
                let directory = try self.getDocumentsDirectory(fileName: file.storage.getFileName(), at: self.defaultDirectory)
                
                if !FileManager.default.fileExists(atPath: directory.url.absoluteString) {
                    try FileManager.default.createDirectory(atPath: directory.url.absoluteString, withIntermediateDirectories: true, attributes: nil)
                }
                
                try data.write(to: directory.urlWithFileName)
            }
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    private func _read(fileStorage: ESFileStorageModel, at directory: ESFileManagerDirectory? = nil, completion: (ESFileModel?, Error?) -> Void) {
        do {
            var file = ESFileModel(data: nil, storage: fileStorage)
            var data: Data?
            
            if let _directory = directory {
                data = try FileManager.default.contents(atPath: self.getDocumentsDirectory(fileName: file.storage.getFileName(), at: _directory).urlWithFileName.path)
            } else {
                data = try FileManager.default.contents(atPath: self.getDocumentsDirectory(fileName: file.storage.getFileName()).urlWithFileName.path)
            }
            
            file.data = data
            completion(file, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    private func _remove(file: ESFileStorageModel, at directory: ESFileManagerDirectory? = nil, completion: (Error?) -> Void) {
        do {
            
            if let _directory = directory {
                try FileManager().removeItem(at: self.getDocumentsDirectory(fileName: file.getFileName(), at: _directory).urlWithFileName)
            } else {
                try FileManager().removeItem(at: self.getDocumentsDirectory(fileName: file.getFileName()).urlWithFileName)
            }
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    private func _listFiles(at directory: ESFileManagerDirectory? = nil, completion: ([ESFileStorageModel]?, Error?) -> Void) {
        
        do {
            var listing: [URL]
            if let _directory = directory {
                listing = try FileManager.default.contentsOfDirectory(at: self.getDocumentsDirectory(fileName: nil, at: _directory).url, includingPropertiesForKeys: nil)
            } else {
                listing = try FileManager.default.contentsOfDirectory(at: self.getDocumentsDirectory(fileName: nil).url, includingPropertiesForKeys: nil)
            }
            
            if listing.count > 0 {
                var model = [ESFileStorageModel]()
                for doc in listing {
                    
                    let docExtensionString = doc.pathComponents.last?.components(separatedBy: ".").last ?? ""
                    let docExtension = ESFileExtensionType.getExtension(by: docExtensionString)
                    let docName = doc.pathComponents.last?.components(separatedBy: docExtension.extensionDescription).first ?? ""
                    model.append(ESFileStorageModel(name: docName, fileExtension: docExtension))
                }
                completion(model, nil)
                return
            } else {
                completion([], nil)
                return
            }
        } catch {
            completion(nil, error)
        }
    }
}

// MARK: ALFileManagerProtocol Impletation

extension ESFileManager: ESFileManagerProtocol {
    
    /// write data file to disk at custom directory
    /// - Parameters:
    ///   - completion: completion block with optional Error
    ///   - file: file to write
    ///   - directory: directory to write
    func write(file: ESFileModel, at directory: ESFileManagerDirectory?, completion: (Error?) -> Void) {
        self._write(file: file, at: directory, completion: completion)
    }
    
    /// Read data file from disk at custom directory
    /// - Parameter completion: completion block with optional data from storage
    /// - Parameter fileStorage: file name and extension
    /// - Parameter directory: directory to write
    func read(fileStorage: ESFileStorageModel, at directory: ESFileManagerDirectory?, completion: (ESFileModel?, Error?) -> Void) {
        self._read(fileStorage: fileStorage, at: directory, completion: completion)
    }
    
    /// Remove file from disk at custom directory
    /// - Parameter completion: completion block with optional Error
    /// - Parameter file: file to remove
    func remove(file: ESFileStorageModel, at directory: ESFileManagerDirectory?, completion: (Error?) -> Void) {
        self._remove(file: file, at: directory, completion: completion)
    }
    
    /// Get list files in storage at custom directory
    /// - Parameter completion: callback block with array of files.
    /// - Parameter directory: custom directory
    func listFiles(at directory: ESFileManagerDirectory?, completion: ([ESFileStorageModel]?, Error?) -> Void) {
        self._listFiles(at: directory, completion: completion)
    }
    
}
