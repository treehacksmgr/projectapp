#import "NewUserViewController.h"
#import <Firebase/Firebase.h>

#import "DonorViewController.h"

@implementation NewUserViewController
- (IBAction)didTabSub:(id)sender {
        NSString * uEmail = self.userEmail.text;
        NSString * uPassword = self.userPassword.text;
        [[FIRAuth auth] createUserWithEmail:uEmail
                                   password:uPassword
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
}];
       
        NSString *title = [self.segment titleForSegmentAtIndex:self.segment.selectedSegmentIndex];
        NSString *uName = self.userName.text;
        FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    
        [[[ref child:@"users"]
          child:@"ind_user"]
         setValue:@{@"username": uName, @"role":title}];
    if ([title isEqualToString:@"Delivery"]){
//        [self
//         presentViewController:[[DonorViewController alloc] init]
//         animated:YES
//         completion:nil];
    }
    else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RootTab"];
        [self
         presentViewController:vc
         animated:YES
         completion:nil];
        
    }
    
}




- (IBAction)userNam:(id)sender {
}
@end

