//
//  QObject.m
//  QuantumSwift
//
//  Created by Wojciech Charysz on 16.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

#import "QObject.h"

@implementation QObject

- (instancetype)init {
    self = [super init];
    
    if (self) {
        using namespace qpp;
        _zero = st.z0;
    }
    
    return self;
}

@end
