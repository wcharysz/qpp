//
//  QNumber.m
//  QuantumSwift
//
//  Created by Wojciech Charysz on 19.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

#import "QNumber.h"
#import <bitset>
#import <qpp.h>

@interface QNumber()

@property (nonatomic, assign) NSInteger integerValue;

@end


@implementation QNumber

- (nonnull instancetype)initWithInteger:(NSInteger)value {
    self = [super init];
    
    if (self) {
        _integerValue = value;
    }
    
    return self;
}

- (void)binaryFromInteger {
    using namespace std;
    
    //Count bits:
    int leadingZeros = __builtin_clzl(self.integerValue);
    int numberOfBits = sizeof(NSInteger) * CHAR_BIT;
    numberOfBits -= leadingZeros;
    int binaryDigit = 1;
    
    do {
        // Int as Binary bit: 1 or 0
        short binaryBit = self.integerValue & binaryDigit ? 1 : 0;
        NSLog(@"binaryBit %d", binaryBit);
        --numberOfBits;
        //Move to the next bit
        binaryDigit <<= 1;
        
    } while (numberOfBits);
    
    using namespace qpp;
    ket G0 = 000_ket;
    ket G1 = 000_ket;
}

@end
