//
//  QInteger.cpp
//  QuantumSwift
//
//  Created by Wojciech Charysz on 28.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

#include "QInteger.hpp"

qpp::QInteger::QInteger(bigint integer) {
    number = integer;
    psi = psiFromInteger();
}

qpp::ket qpp::QInteger::psiFromInteger() {
    int numberOfBits = sizeof(bigint) * CHAR_BIT;
    numberOfBits -= __builtin_clzl(number);
    
    using namespace qpp;
    int binaryDigit = 1;
    std::vector<idx> bits;
    
    do {
        // Int as Binary bit
        bits.push_back(number & binaryDigit ? 1 : 0);
        --numberOfBits;
        //Move to the next bit
        binaryDigit <<= 1;
        
    } while (numberOfBits);
    
    return mket(bits);
}

qpp::bigint qpp::QInteger::integerFromPsi() {
    using namespace qpp;
    auto measured = measure(psi, gt.H);
    
    return 0;
}

