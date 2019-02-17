//
//  ReturningUserViewController.m
//  app3
//
//  Created by Mark Scarsi on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "ReturningUserViewController.h"
#import <Firebase/Firebase.h>



@implementation ReturningUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onSubmit:(id)sender {
    NSString * rUEmail = self.rUserEmail.text;
    NSString * rUPassword = self.rUserPassword.text;
    [[FIRAuth auth] signInWithEmail:rUEmail password:rUPassword completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if (!error) {
            NSString *userID = [FIRAuth auth].currentUser.uid;
            FIRDatabaseReference *ref;
            ref = [[FIRDatabase database] reference];
            [[[ref child:@"users"] child:userID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                NSString * job = @"";
                if ([job isEqualToString:@"Donate"]){
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"UserFlow" bundle:nil];
                    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"UserFlow"];
                    [self
                     presentViewController:vc
                     animated:YES
                     completion:nil];
                }
                else{
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RootTab"];
                    [self presentViewController:vc animated:YES completion:nil];
                }
            }];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

