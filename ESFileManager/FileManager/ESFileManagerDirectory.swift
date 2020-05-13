//
//  ESFileManagerDirectory.swift
//  ESFileManager
//
//  Created by Дмитрий Торопкин on 13.05.2020.
//  Copyright © 2020 Dmitriy Toropkin. All rights reserved.
//

import Foundation

public enum ESFileManagerDirectory {
    
    /// Use this directory to store user-generated content. The contents of this directory can be made available to the user through file sharing; therefore, this directory should only contain files that you may wish to expose to the user. The contents of this directory are backed up by iTunes and iCloud.
    /// - Parameters:
    ///   - useBackups: back up this data to iTunes and iCloud
    ///   - urlPath: additional path for custom directory in documents folder. Defailt is nil.
    case documents(urlPath: String? = nil, useBackups: Bool)

    /// Use this Library subdirectories for any files you don’t want exposed to the user. Your app should not use these directories for user data files.  The contents of this directory can be backed up by iTunes and iCloud.
    /// - Parameters:
    ///   - useBackups: back up this data to iTunes and iCloud
    ///   - urlPath: additional path for custom directory in applicationSupport folder. Defailt is nil.
    case applicationSupport(urlPath: String? = nil, useBackups: Bool)
    
    /// Use this directory to write any app-specific support files that your app can re-create easily. Your app is generally responsible for managing the contents of this directory and for adding and deleting files as needed. In iOS 5.0 and later, the system may delete the Caches directory on rare occasions when the system is very low on disk space. This will never occur while an app is running. However, be aware that restoring from backup is not necessarily the only condition under which the Caches directory can be erased.
    /// - Parameters:
    ///   - urlPath: additional path for custom directory in caches folder. Defailt is nil.
    case caches(urlPath: String? = nil)
    
    /// Use this directory to write temporary files that do not need to persist between launches of your app. Your app should remove files from this directory when they are no longer needed; however, the system may purge this directory when your app is not running. The contents of this directory are not backed up by iTunes or iCloud.
    case tmp
}
