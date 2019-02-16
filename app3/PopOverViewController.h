//
//  PopOverViewController.h
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopOverViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *DoneButton;
@property (weak, nonatomic) IBOutlet UIImageView *organizationPic;
@property (weak, nonatomic) IBOutlet UILabel *foodType;
@property (weak, nonatomic) IBOutlet UILabel *TimeAvail;
@property (weak, nonatomic) IBOutlet UILabel *DistanceLabel;

@end

NS_ASSUME_NONNULL_END
