//
//  Giver.h
//  app3
//
//  Created by Mark Scarsi on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//
#import <Firebase/Firebase.h>
#import <Foundation/Foundation.h>
@import Firebase;
NS_ASSUME_NONNULL_BEGIN
@interface Giver : NSObject
@property (strong, nonatomic) FIRDatabase * apple;
@end

NS_ASSUME_NONNULL_END
