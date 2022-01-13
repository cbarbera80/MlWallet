//
//  FilesManagerTests.swift
//  
//
//  Created by Claudio Barbera on 12/01/22.
//

import XCTest
@testable import MyLimeWallet

class FilesManagerTests: XCTestCase {

    var sut: FilesManager!
    
    override func setUp() {
        sut = FilesManager()
        sut.removeAllFiles()
    }
    
    override func tearDown() {
        sut.removeAllFiles()
    }

    func test_afterCreation_fileShouldExist() throws {
        // Given
        let data = "test".data(using: .utf8)!
        
        // when
        let filename = sut.createFile(withContents: data)
        
        let fileExists = sut.isFileExists(filename)
        XCTAssertTrue(fileExists)
    
    }

    func test_afterDeletion_fileShouldNotExist() throws {
        // given
        let data = "test".data(using: .utf8)!
        
        // when
        let filename = sut.createFile(withContents: data)
        sut.removeFile(filename)
        
        // then
        let fileExists = sut.isFileExists(filename)
        XCTAssertFalse(fileExists)
    }
    
    func test_afterCreateTwoFiles_totalFilesShouldBe2() throws {
        // given
        let data1 = "test".data(using: .utf8)!
        let data2 = "test".data(using: .utf8)!
        
        
        // when
        _ = sut.createFile(withContents: data1)
        _ = sut.createFile(withContents: data2)
        
        let allFilesCount = sut.getAllFiles()
            .filter { !$0.starts(with: ".") } // Ignore hidden files
            .count
        
        // then
        XCTAssertTrue(allFilesCount == 2)
    }
    
    func test_afterCreation_contentsShouldBeCorrect() throws {
        // given
        let data = "test".data(using: .utf8)!
        let filename = sut.createFile(withContents: data)
        
        // when
        let file = sut.getFile(withName: filename)!
        let output = String(data: file, encoding: .utf8)
        
        // then
        XCTAssertEqual(output, "test")
        
    }
}
