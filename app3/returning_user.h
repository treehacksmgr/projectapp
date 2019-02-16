//
//  returning_user.h
//  app3
//
//  Created by Mark Scarsi on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface returning_user : NSObject
@property (strong, nonatomic) IBOutlet UITextField * email2;
@property (strong, nonatomic) IBOutlet UITextField * password2;
@property (strong, nonatomic) IBOutlet UIButton * submit1;
@end

NS_ASSUME_NONNULL_END
