//
//  UploadViewController.h
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *uploadedImage;
@property (weak, nonatomic) IBOutlet UITextField *foodTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endingDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;


@end

NS_ASSUME_NONNULL_END
