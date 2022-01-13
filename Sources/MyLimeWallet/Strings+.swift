//
//  File.swift
//  
//
//  Created by Claudio Barbera on 12/01/22.
//

import Foundation

extension String {
    static func randomString(ofLength length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
