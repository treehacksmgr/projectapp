//
//  UploadViewController.m
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "UploadViewController.h"
#import "Donation.h"

@interface UploadViewController ()

@property (strong, nonatomic) NSData *imageData;

@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    tapGesture1.numberOfTapsRequired = 1;
    
    tapGesture1.delegate = self;
    
    [self.uploadedImage addGestureRecognizer:tapGesture1];
    
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
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    newDonation.quantity = [f numberFromString:self.quantityTextField.text];
    //NSLog(@"yeahhh babyy");
    [self addDonationtoFB:newDonation];
}

-(void) addDonationtoFB:(Donation *)addDonation{
    NSLog(@"here");
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
