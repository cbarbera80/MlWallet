//
//  File.swift
//  
//
//  Created by Claudio Barbera on 12/01/22.
//

import Foundation
import web3swift
import Web3Core

public struct Credential {
    var keystore: BIP32Keystore
    var manager: KeystoreManager
    
    var address: EthereumAddress? {
        return manager.addresses?.first
    }
}
