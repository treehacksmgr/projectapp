//
//  new_user.m
//  app3
//
//  Created by Mark Scarsi on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "new_user.h"
#import <Firebase/Firebase.h>
@implementation new_user
NSString *email;
NSString *password;
- (IBAction)email1:(id)sender {
    email = self.email1.text;
}
- (IBAction)password1:(id)sender {
    password = self.password1.text;
}
- (IBAction)submit:(id)sender {
    [[FIRAuth auth] createUserWithEmail:email
                    password:password
                    completion:^(FIRAuthDataResult * _Nullable authResult,
                                 NSError * _Nullable error) {
    }];
    FIRFirestore * apple;
    //[[[apple collectionWithPath:@"users"] documentWithPath:@"names"] addDocumentWithData:@{ @"firstName": @user_name}];
}

@end
