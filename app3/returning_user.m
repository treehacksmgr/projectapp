//
//  returning_user.m
//  app3
//
//  Created by Mark Scarsi on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "returning_user.h"
#import <Firebase/Firebase.h>
@implementation returning_user
NSString *email;
NSString *password;
- (IBAction)email2:(id)sender {
    email = self.email2.text;
}
- (IBAction)password2:(id)sender {
    password = self.password2.text;
}
- (IBAction)submit1:(id)sender {
    [[FIRAuth auth] signInWithEmail:email
                           password:password
                         completion:^(FIRAuthDataResult * _Nullable authResult,
                                      NSError * _Nullable error) {
                            
                         }];
}

@end
