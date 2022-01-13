//
//  File.swift
//  
//
//  Created by Claudio Barbera on 12/01/22.
//

import Foundation

class FilesManager {
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    
    var url: URL {
        URL(fileURLWithPath: path)
    }
    
    let fileManager = FileManager.default
    
    func createFile(withContents contents: Data, fileName: String = String.randomString(ofLength: 8)) -> String {
        let filePath = url.appendingPathComponent(fileName)
        FileManager.default.createFile(atPath: filePath.absoluteString, contents: contents, attributes: nil)
        return fileName
    }
    
    func isFileExists(_ fileName: String) -> Bool {
        let filePath = url.appendingPathComponent(fileName)
        return fileManager.fileExists(atPath: filePath.absoluteString)
    }
    
    func removeFile(_ fileName: String) {
        let filePath = url.appendingPathComponent(fileName)
        try? fileManager.removeItem(atPath: filePath.absoluteString)
    }
    
    func getFile(withName fileName: String) -> Data? {
        let filePath = url.appendingPathComponent(fileName)
        return try? Data(contentsOf: filePath)
    }
    
    func removeAllFiles() {
        for file in getAllFiles() {
            removeFile(file)
        }
    }
    
    func getAllFiles() -> [String] {
        return (try? fileManager.contentsOfDirectory(atPath: url.absoluteString)) ?? []
    }
    
}
