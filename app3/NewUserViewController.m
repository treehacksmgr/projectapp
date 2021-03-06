#import "NewUserViewController.h"
#import <Firebase/Firebase.h>

#import "UploadViewController.h"

@implementation NewUserViewController

- (IBAction)didTapGesture:(id)sender {
    [self.view endEditing:YES];
}
- (void)logoutButtonPressed
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Invalid Password"
                                 message:@"Enter a Password with Six or More Letters"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)didTabSub:(id)sender {
        NSString * uEmail = self.userEmail.text;
        NSString * uPassword = self.userPassword.text;
    if ([uPassword length] < 6){
        [self logoutButtonPressed];
        
    }
        [[FIRAuth auth] createUserWithEmail:uEmail
                                   password:uPassword
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
                                     
                                     NSString *userID = [FIRAuth auth].currentUser.uid;
                                     NSString *title = [self.segment titleForSegmentAtIndex:self.segment.selectedSegmentIndex];
                                     NSString *uName = self.userName.text;
                                     FIRDatabaseReference *ref = [[FIRDatabase database] reference];
                                     
                                     [[[ref child:@"users"]
                                       child:userID]
                                      setValue:@{ @"name":uName,@"role":title,@"email":uEmail}];
                                     if ([title isEqualToString:@"Donate"]){
                                         UIStoryboard *sb = [UIStoryboard storyboardWithName:@"UserFlow" bundle:nil];
                                         UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"UserFlow"];
                                         [self
                                          presentViewController:vc
                                          animated:YES
                                          completion:nil];
                                     }
                                     else{
                                         //main thread dispatch_main_async
                                         UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                         UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"RootTab"];
                                         [self
                                          presentViewController:vc
                                          animated:YES
                                          completion:nil];
                                         
                                     }
            }];
}




- (IBAction)userNam:(id)sender {
}
@end

