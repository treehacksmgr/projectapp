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
#import <Firebase/Firebase.h>

NS_ASSUME_NONNULL_BEGIN

@interface DonationTableViewController : UIViewController <UITableViewDataSource, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *donationsMutable;
@property (strong, nonatomic) NSArray *donations;
@property (weak, nonatomic) IBOutlet UIView *distanceView;
@property (weak, nonatomic) IBOutlet UIView *portionView;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (strong, nonatomic) FIRDatabaseReference *ref;


@end

NS_ASSUME_NONNULL_END
