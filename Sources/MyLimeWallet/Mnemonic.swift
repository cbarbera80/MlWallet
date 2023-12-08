//
//  File.swift
//  
//
//  Created by Claudio Barbera on 12/01/22.
//

import Foundation
import web3swift
import Web3Core

public class Mnemonic: Codable {

    public let phrase: String
    
    public var words: [String] {
        return phrase
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: " ")
            .map { String($0) }
    }
    
    public init?(phrase: String) {
        guard BIP39.mnemonicsToEntropy(phrase) != nil else { return nil }
        self.phrase = phrase
    }
    
    var isValid: Bool {
        let data = BIP39.mnemonicsToEntropy(phrase)
        return data != nil
    }
}
