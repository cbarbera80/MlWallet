//
//  File.swift
//  
//
//  Created by Claudio Barbera on 12/01/22.
//

import Foundation

struct MlEcSignature: CustomStringConvertible {
    
    let r: Data
    let s: Data
    let v: Data
    
    var flatten: Data {
        r + s + v
    }
    
    var description: String {
        "r: \(r.toHexString())\ns:\(s.toHexString())\nv:\(v.toHexString())"
    }
}
