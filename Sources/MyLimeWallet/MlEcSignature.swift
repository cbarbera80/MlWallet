//
//  File.swift
//  
//
//  Created by Claudio Barbera on 12/01/22.
//

import Foundation

public struct MlEcSignature: CustomStringConvertible {
    
    public let r: Data
    public let s: Data
    public let v: Data
    
    public var flatten: Data {
        r + s + v
    }
    
    public var description: String {
        "r: \(r.toHexString())\ns:\(s.toHexString())\nv:\(v.toHexString())"
    }
}
