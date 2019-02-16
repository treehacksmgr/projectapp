//
//  new_user.h
//  app3
//
//  Created by Mark Scarsi on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface new_user : NSObject
@property (strong, nonatomic) IBOutlet UITextField *email1;
@property (strong, nonatomic) IBOutlet UITextField *password1;
@property (strong, nonatomic) IBOutlet UIButton *submit;
@end

NS_ASSUME_NONNULL_END
