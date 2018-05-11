//
//  ObjCqpp.m
//  QuantumSwift
//
//  Created by Wojciech Charysz on 10.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

#import "ObjCqpp.h"
#import <qpp.h>

@implementation ObjCqpp

- (void)minimal {
    
    qpp::ket zero = qpp::st.z0;
    NSLog(@"Hello Quantum++!\nThis is the |0> state:\n");
}

@end
