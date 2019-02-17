//
//  UploadViewController.m
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "UploadViewController.h"
#import "Donation.h"
#import <Firebase/Firebase.h>

@interface UploadViewController ()

@property (strong, nonatomic) NSData *imageData;

@end

@implementation UploadViewController{
    CLLocationManager *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    tapGesture1.numberOfTapsRequired = 1;
    
    tapGesture1.delegate = self;
    
    [self.uploadedImage addGestureRecognizer:tapGesture1];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
}

- (void) tapGesture: (id)sender
{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated: YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{
    UIImage *editedPicture = info[UIImagePickerControllerEditedImage];
    self.imageData = UIImagePNGRepresentation(editedPicture);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    self.uploadedImage.image = editedPicture;
}
- (IBAction)changingDate:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)didTapPost:(id)sender {
    Donation *newDonation = [[Donation alloc] init];

    newDonation.donationImageData = self.imageData;
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"HH:mm"]; //24hr time format
    NSString *dateStringStart = [outputFormatter stringFromDate:self.datePicker.date];
    NSString *dateStringEnd = [outputFormatter stringFromDate:self.endingDatePicker.date];
    newDonation.startTime = dateStringStart;
    newDonation.endTime = dateStringEnd;
    newDonation.foodType = self.foodTextField.text;
    newDonation.donationTitle = self.titleTextField.text;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    newDonation.quantity = [f numberFromString:self.quantityTextField.text];
    newDonation.latitude = [NSNumber numberWithDouble:locationManager.location.coordinate.latitude];
    newDonation.longitude = [NSNumber numberWithDouble:locationManager.location.coordinate.longitude];
    //NSLog(@"yeahhh babyy");
    [self addDonationtoFB:newDonation];
}

-(void) addDonationtoFB:(Donation *)addDonation{
    
    NSString *userID = [FIRAuth auth].currentUser.uid;
    NSString *picToStr = [addDonation.donationImageData base64EncodedStringWithOptions:0];
    FIRDatabaseReference *refe = [[FIRDatabase database] reference];
    NSString *str = @"users/";
    str = [str stringByAppendingString:userID];
    str = [str stringByAppendingString:@"/donations/"];
    str = [str stringByAppendingString:addDonation.donationTitle];
    FIRDatabaseReference *userRef = [refe child:str];
    NSDictionary *newUserData = @{@"quant":addDonation.quantity,@"fType":addDonation.foodType,@"sTime":addDonation.startTime,
          @"eTime":addDonation.endTime,@"long":addDonation.longitude,@"lat":addDonation.latitude,
          @"pictureAsStr":picToStr};
    [userRef updateChildValues: newUserData];
}
@end

