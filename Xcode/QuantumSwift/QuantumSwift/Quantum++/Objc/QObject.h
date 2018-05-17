//
//  QObject.h
//  QuantumSwift
//
//  Created by Wojciech Charysz on 16.05.2018.
//  Copyright © 2018 Wojciech Charysz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <qpp.h>

@interface QObject : NSObject

@property (nonatomic, assign) qpp::ket zero;
//@property (nonatomic, copy) (BOOL (NS_NOESCAPE ^)(ObjectType obj, NSUInteger idx, BOOL *stop))predicate;

@end
