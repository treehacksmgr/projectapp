//
//  Donation.h
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Donation : NSObject

@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, strong) NSNumber *timeLimit;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *orgName;
@property (nonatomic, strong) NSNumber *distance;

@end

NS_ASSUME_NONNULL_END
