//
//  Donation.h
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Donation : NSObject

@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *donationTitle;
@property NSData *donationImageData;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSString *foodType;

@end

NS_ASSUME_NONNULL_END
