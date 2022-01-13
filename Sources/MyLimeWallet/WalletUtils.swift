//
//  File.swift
//  
//
//  Created by Claudio Barbera on 12/01/22.
//

import Foundation
import web3swift

class WalletUtility {
    
    enum WalletUtilityError: Error {
        case invalidJSONData
    }
    
    private let fileManager: FilesManager
    
    init(fileManager: FilesManager) {
        self.fileManager = fileManager
    }
    
    func save(params: KeystoreParamsBIP32) throws -> String {
       
        guard let keyData = try? JSONEncoder().encode(params) else {
            throw WalletUtilityError.invalidJSONData
        }
        
        return fileManager.createFile(withContents: keyData)
    }
    
    func loadData(from fileName: String) -> Data? {
        guard let data = fileManager.getFile(withName: fileName)
        else {
            return nil
        }
        
        return data
    }
}
