//
//  ESFileManagerTests.swift
//  ESFileManagerTests
//
//  Created by Дмитрий Торопкин on 13.05.2020.
//  Copyright © 2020 Dmitriy Toropkin. All rights reserved.
//

import XCTest
@testable import ESFileManager

class ESFileManagerTests: XCTestCase {
    
    var diskManager: ESFileManagerProtocol!
    
    override func setUp() {
        super.setUp()
        self.diskManager = ESFileManager(defaultFileInfo: ESFileModel(name: "Test"), defaultDirectory: .caches(urlPath: "Test"))
   }
    
    override func tearDown() {
        super.tearDown()
        self.diskManager = nil
    }
    
    func testWriteReadCycle() {
        let data = "AdvancedLoggerFileManagerTest".data(using: .utf8) ?? Data()
        self.diskManager.write(data: data) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
        self.diskManager.read { (_data, error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
            XCTAssertEqual(data, _data)
        }
    }
    
}
