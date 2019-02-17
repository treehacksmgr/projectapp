//
//  DonationTableViewController.h
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Donation.h"

NS_ASSUME_NONNULL_BEGIN

@interface DonationTableViewController : UIViewController <UITableViewDataSource, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *donationsMutable;
@property NSArray *donations;
@property (strong, nonatomic) Donation *donate1;
@property (strong, nonatomic) Donation *donate2;
@property (strong, nonatomic) Donation *donate3;

@end

NS_ASSUME_NONNULL_END
