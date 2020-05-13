//
//  ESFIleModel.swift
//  ESFileManager
//
//  Created by Дмитрий Торопкин on 13.05.2020.
//  Copyright © 2020 Dmitriy Toropkin. All rights reserved.
//

import Foundation

/// Model of file on disk. Contain Data and file storage model (like file name and file extension)
public struct ESFileModel {
    
    /// data represent of file
    public var data: Data?
    /// file storage model (like file name and file extension)
    public var storage: ESFileStorageModel
    
    /// Init model
    /// - Parameters:
    ///   - data: data represent of file
    ///   - storage: storage model (file name and extension)
    public init(data: Data?, storage: ESFileStorageModel) {
        self.data = data
        self.storage = storage
    }
}
