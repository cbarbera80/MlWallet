//
//  File.swift
//  
//
//  Created by Claudio Barbera on 12/01/22.
//

import Foundation

public enum MlWalletException: Error {
    case missingMnemonics
    case invalidKeystore
    case invalidAddress
    case invalidPublicKey
    case missingKeys
    case invalidStore
    case invalidEthereumAddress
    case signError
}
