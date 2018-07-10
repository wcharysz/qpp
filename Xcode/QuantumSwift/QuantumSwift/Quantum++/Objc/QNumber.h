//
//  QNumber.h
//  QuantumSwift
//
//  Created by Wojciech Charysz on 19.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNumber : NSObject

- (nonnull instancetype)initWithInteger:(NSInteger)value;
+ (int)numberOfBits:(NSInteger)number;

@end
