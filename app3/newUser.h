//
//  newUser.h
//  app3
//
//  Created by Mark Scarsi on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface newUser : NSObject
@property (strong, nonatomic) IBOutlet UITextField *userEmail;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@end

NS_ASSUME_NONNULL_END