//
//  ESFileManagerProtocol.swift
//  ESFileManager
//
//  Created by Дмитрий Торопкин on 13.05.2020.
//  Copyright © 2020 Dmitriy Toropkin. All rights reserved.
//

import Foundation

// MARK: - ESFileManagerProtocol

/// Protocol for Manager for write and read file from bundle
public protocol ESFileManagerProtocol {
    
    /// write data file to disk at directory. For default directory from init set at: nil
    /// - Parameters:
    ///   - completion: completion block with optional Error
    ///   - file: file to write
    ///   - directory: directory to write. Set nil for directory from init
    func write(file: ESFileModel, at directory: ESFileManagerDirectory?, completion: ((Error?) -> Void)?)
    
    /// Read data file from disk at directory. For default directory from init set at: nil
    /// - Parameter completion: completion block with optional data from storage
    /// - Parameter fileStorage: file name and extension
    /// - Parameter directory: directory to write. Set nil for directory from init
    func read(fileStorage: ESFileNameModel, at directory: ESFileManagerDirectory?, completion: ((ESFileModel?, Error?) -> Void)?)
    
    /// Remove file from disk at directory. For default directory from init set at: nil
    /// - Parameter completion: completion block with optional Error
    /// - Parameter file: file to remove
    func remove(file: ESFileNameModel, at directory: ESFileManagerDirectory?, completion: ((Error?) -> Void)?)
    
    /// Get list files in storage at directory. For default directory from init set at: nil
    /// - Parameter completion: callback block with array of files.
    /// - Parameter directory: directory. Set nil for directory from init
    func listFiles(at directory: ESFileManagerDirectory?, completion: (([ESFileNameModel]?, Error?) -> Void)?)
}
