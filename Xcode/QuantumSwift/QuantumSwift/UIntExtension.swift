//
//  UIntExtension.swift
//  QuantumSwift
//
//  Created by Wojciech Charysz on 11.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

import Foundation

extension UInt {
    func numberOfDigits() -> UInt {
        return abs(Int32(self)) < 10 ? 1 : 1 + (self / 10).numberOfDigits()
    }
    
    var digits: [UInt] {
        let number = numberOfDigits()
        var temporaryNumber = self
        
        var digits: [UInt] = Array()
        
        for index in (0...number-1).reversed() {
            let divider = UInt(pow(Double(10), Double(index)))
            let digit = temporaryNumber /  divider
            digits.append(digit)
            temporaryNumber -= digit * divider
        }
        
        return digits
    }
}
