//
//  GCD.swift
//  QuantumSwift
//
//  Created by Wojciech Charysz on 11.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

class GCD: NSObject {
    
    static func gcd(_ u: UInt, _ v: UInt) -> UInt {
        if u == 0 {
            return v
        }
        
        if v == 0 {
            return u
        }
        
        var a = abs(Int32(u))
        var b = abs(Int32(v))
        
        if (b > a) {
            swap(&a, &b)
        }
        
        while (b > 0) {
            (a, b) = (b, a % b)
        }

        return UInt(a)
    }
}
