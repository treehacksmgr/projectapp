//
//  newUser.m
//  app3
//
//  Created by Mark Scarsi on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "newUser.h"
#import <Firebase/Firebase.h>
@implementation newUser
- (IBAction)submitBaby:(id)sender {
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"submitToMain"]){
        printf("HERE!");
        NSString * uEmail = self.userEmail.text;
        NSString * uPassword = self.userPassword.text;
        [[FIRAuth auth] createUserWithEmail:uEmail
                                   password:uPassword
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
                                 }];
        NSString * uName = self.userName.text;
        FIRDatabaseReference *ref;
        ref = [[FIRDatabase database] reference];
        [[[ref child:@"users"] child:@"ind_user"]
         setValue:@{@"username": uName}];
    }
    
}
         

@end
