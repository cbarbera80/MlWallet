//
//  File.swift
//  
//
//  Created by Claudio Barbera on 12/01/22.
//

import Foundation


public class Mnemonic {

    public let phrase: String
    
    public var words: [String] {
        return phrase
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: " ")
            .map { String($0) }
    }
    
    init(phrase: String) {
        self.phrase = phrase
    }
}
