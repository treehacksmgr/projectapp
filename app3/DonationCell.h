//
//  DonationCell.h
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DonationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *donationImage;
@property (weak, nonatomic) IBOutlet UILabel *donationTitle;
@property (weak, nonatomic) IBOutlet UILabel *distanceLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *servingLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodLabel;

@end

NS_ASSUME_NONNULL_END
