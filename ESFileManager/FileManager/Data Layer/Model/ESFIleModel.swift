//
//  ESFIleModel.swift
//  ESFileManager
//
//  Created by Дмитрий Торопкин on 13.05.2020.
//  Copyright © 2020 Dmitriy Toropkin. All rights reserved.
//

import Foundation

/// File format for write on disk
public enum ESFileFormatModel: String {
    case txt = ".txt"
}

public struct ESFileModel {
    public var name: String
    public var fileFormat: ESFileFormatModel
    
    public init(name: String, fileFormat: ESFileFormatModel = .txt) {
        self.name = name
        self.fileFormat = fileFormat
    }
    
    func getFileName() -> String {
        return self.name + self.fileFormat.rawValue
    }
}
