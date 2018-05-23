//
//  QNumber.m
//  QuantumSwift
//
//  Created by Wojciech Charysz on 19.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

#import "QNumber.h"
#import <qpp.h>

@interface QNumber()

@property (nonatomic, assign) NSInteger integerValue;
@property (nonatomic, assign) qpp::ket psi;

@end


@implementation QNumber

- (nonnull instancetype)initWithInteger:(NSInteger)value {
    self = [super init];
    
    if (self) {
        _integerValue = value;
        _psi = [self psiFromInteger:value];
    }
    
    return self;
}

- (int)numberOfBits:(NSInteger)number {
    int numberOfBits = sizeof(NSInteger) * CHAR_BIT;
    numberOfBits -= __builtin_clzl(number);
    
    return numberOfBits;
}

- (qpp::ket)psiFromInteger:(NSInteger)value {
    using namespace qpp;
    
    //Count bits:
    int numberOfBits = [self numberOfBits:value];
    int binaryDigit = 1;
    std::vector<idx> bits;
    
    do {
        // Int as Binary bit
        bits.push_back(value & binaryDigit ? 1 : 0);
        --numberOfBits;
        //Move to the next bit
        binaryDigit <<= 1;
        
    } while (numberOfBits);
    
    NSLog(@"END");
    
    return mket(bits);
}

@end
