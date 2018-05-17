//
//  ObjCqpp.h
//  QuantumSwift
//
//  Created by Wojciech Charysz on 10.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjCqpp : NSObject

- (void)minimal;
- (nullable NSArray<NSNumber *> *)shorFor:(NSInteger)number;
- (NSUInteger)qubitsRequiredFor:(NSUInteger)number;
- (void)groverFor:(NSUInteger)number inArray:(nonnull NSArray<NSNumber  *> *)array;

@end
