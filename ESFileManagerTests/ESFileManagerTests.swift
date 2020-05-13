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
        self.diskManager = ESFileManager(defaultDirectory: .documents(useBackups: false))
   }
    
    override func tearDown() {
        super.tearDown()
        self.diskManager = nil
    }
    
    func testWriteReadCycle() {
        let data = "AdvancedLoggerFileManagerTest".data(using: .utf8) ?? Data()
        let file = ESFileModel(data: data, storage: ESFileStorageModel(name: "Test", fileExtension: .txt))
        self.diskManager.write(file: file, at: nil) { (error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
        }
        self.diskManager.read(fileStorage: ESFileStorageModel(name: "Test", fileExtension: .txt), at: nil) { (_data, error) in
            XCTAssertNil(error, error?.localizedDescription ?? "")
            XCTAssertEqual(data, _data?.data)
        }
    }
    
    func testList() {
        self.diskManager.listFiles(at: nil) { (model, error) in
            XCTAssertGreaterThan(model?.count ?? 0, 0)
        }
    }
    
}
