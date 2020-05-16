//
//  ESFileStorageModel.swift
//  ESFileManager
//
//  Created by Дмитрий Торопкин on 13.05.2020.
//  Copyright © 2020 Dmitriy Toropkin. All rights reserved.
//

import Foundation

/// File format for write on disk
public enum ESFileExtensionType {
    case txt
    case custom(extensionName: String)
    
    var extensionDescription: String {
        switch self {
        case .txt: return ".txt"
        case .custom(extensionName: let extensionName): return extensionName
        }
    }
    
    static func getExtension(by type: String) -> ESFileExtensionType {
        switch type {
        case "txt": return .txt
        default: return .custom(extensionName: type)
        }
    }
}

/// file storage model ( file name and file extension)
public struct ESFileNameModel {
    /// file name
    public var name: String
    /// file extension
    public var fileExtension: ESFileExtensionType
    
    /// Init for model
    /// - Parameters:
    ///   - name: file name
    ///   - fileExtension: file extension
    public init(name: String, fileExtension: ESFileExtensionType) {
        self.name = name
        self.fileExtension = fileExtension
    }
    
    func getFileName() -> String {
        return self.name + self.fileExtension.extensionDescription
    }
}
