//
//  DonationTableViewController.m
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "DonationTableViewController.h"


@interface DonationTableViewController ()

@end

@implementation DonationTableViewController{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D location2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //making fake data to test the table
    self.donationsMutable = [[NSMutableArray alloc] init];
    self.donations = [[NSArray alloc] init];
    //[self populateFakeData];
    [self queryForDonations];
    
//    self.donations = @[@"New York, NY", @"Los Angeles, CA", @"Chicago, IL", @"Houston, TX",
//             @"Philadelphia, PA", @"Phoenix, AZ", @"San Diego, CA", @"San Antonio, TX",
//             @"Dallas, TX", @"Detroit, MI", @"San Jose, CA", @"Indianapolis, IN",
//             @"Jacksonville, FL"];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DonationCell"];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];

    location2.latitude = locationManager.location.coordinate.latitude;
    location2.longitude = locationManager.location.coordinate.longitude;
    
    NSLog(@"help");
}

-(void) populateFakeData{
    self.donate1 = [[Donation alloc] init];
    self.donate1.latitude = [NSNumber numberWithDouble:37.4198];
    self.donate1.longitude = [NSNumber numberWithDouble:-122.0788];
    //donate1.startTime =
    self.donate1.quantity = [NSNumber numberWithDouble:20];
    //self.donate1.orgName = @"Google HQ";
    
    self.donate2 = [[Donation alloc] init];
    self.donate2.latitude = [NSNumber numberWithDouble:35.7877];
    self.donate2.longitude = [NSNumber numberWithDouble:-78.6442];
    //donate1.startTime =
    self.donate2.quantity = [NSNumber numberWithDouble:12];
    //self.donate2.orgName = @"Raleigh";
    
    self.donate3 = [[Donation alloc] init];
    self.donate3.latitude = [NSNumber numberWithDouble:32.7157];
    self.donate3.longitude = [NSNumber numberWithDouble:-117.1610];
    //donate1.startTime =
    self.donate3.quantity = [NSNumber numberWithDouble:1];
    //self.donate3.orgName = @"San Diego";
    
    [self.donationsMutable addObject:self.donate1];
    [self.donationsMutable addObject:self.donate2];
    [self.donationsMutable addObject:self.donate3];
    self.donations = [NSArray arrayWithArray:self.donationsMutable];
    
}

-(void)queryForDonations{

    FIRDatabaseReference *rootRef= [[FIRDatabase database] reference];
    [rootRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot)
     {
         if (snapshot.exists)
         {
             //NSLog(@"%@",snapshot.value);
             NSDictionary *help = snapshot.value[@"users"];
             
             for (NSString* key in help.allKeys) {
                 if ([help objectForKey:key][@"donations"] != NULL) {
                     Donation *newDonor = [[Donation alloc] init];
                     NSDictionary *smallDict = [help objectForKey:key][@"donations"];
                     NSString* key1 = smallDict.allKeys[0];
                     newDonor.donationTitle = key1;
                     NSLog(@"%@", key1);
                     NSDictionary *smallerDict = smallDict[key1];
                     newDonor.foodType = smallerDict[@"fType"];
                     //NSString *quantString = smallerDict[@"quant"];
                     //newDonor.quantity = [NSNumber numberWithDouble:quantString.doubleValue];
                     NSString *nameString = [help objectForKey:key][@"name"];
                     newDonor.orgName = nameString;
                     NSLog(@"here");
                 }
                 
//                 NSString *value = [help objectForKey:key];
//                 NSLog(@" value = %@",value);
//                 NSLog(@"key = %@",key);
                 //NSString *value = [help objectForKey:key];
                 //NSDictionary *smallerDict = [help objectForKey:key][@"donations"];
                 //NSLog(@"small dict = %@", smallerDict);
                 
             }
         } else {
             NSLog(@"fuck me");
         }
     }];
    //NSLog(@"testing query");
    //FIRDataEventTypeValue *refhandle;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    Donation *returnedDonation = self.donations[indexPath.row];
    //cell.textLabel.text = returnedDonation.orgName;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.donations.count;
}

- (IBAction)didTapDistance:(id)sender {
    [self sortDonationsByDistance];
    [self.tableView reloadData];
    self.distanceView.backgroundColor = [UIColor colorWithRed:0 green:10 blue:60 alpha:1];
    self.portionView.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:1];
    self.timeView.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:1];
    
}

- (IBAction)didTapQuantity:(id)sender {
    [self sortDonationsByQuantity];
    [self.tableView reloadData];
    self.distanceView.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:1];
    self.portionView.backgroundColor = [UIColor colorWithRed:0 green:10 blue:60 alpha:1];
    self.timeView.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:1];
}

- (IBAction)didTapTime:(id)sender {
    [self sortDonationsByTime];
    [self.tableView reloadData];
    self.distanceView.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:1];
    self.portionView.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:1];
    self.timeView.backgroundColor = [UIColor colorWithRed:0 green:10 blue:60 alpha:.8];
}


-(void)sortDonationsByDistance{
    CLLocation *currentLocation = [[CLLocation alloc] initWithLatitude:location2.latitude longitude:location2.longitude];
    for (int i = 0; i < self.donations.count; i++) {
        Donation *returnedDonation = self.donations[i];
        CLLocation *donationLocation = [[CLLocation alloc] initWithLatitude:[returnedDonation.latitude doubleValue] longitude:[returnedDonation.longitude doubleValue]];
        CLLocationDistance distance = [currentLocation distanceFromLocation:donationLocation];
        //Donation *newDonation = self.donations[i];
        returnedDonation.distance = [NSNumber numberWithDouble:distance];
        
        //newDonation[@"distance"] = [NSNumber numberWithDouble:distance];
    }
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];
    self.donations = [self.donations sortedArrayUsingDescriptors:@[sortDescriptor]];
}

-(void)sortDonationsByQuantity{
    
//    for (int i = 0; i < self.donations.count; i++) {
//        Donation *returnedDonation = self.donations[i];
//        self.donations[i][@"quantity"] = returnedDonation.quantity;
//    }
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"quantity" ascending:YES];
    self.donations = [self.donations sortedArrayUsingDescriptors:@[sortDescriptor]];
    
}

-(void)sortDonationsByTime{
//    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
//    // NSTimeInterval is defined as double
//    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
//    double donationMinuteInSeconds;
//    double timeInSeconds = [timeStampObj doubleValue];
//    double timeTillExpire;
//    for (int i = 0; i < self.donations.count; i++) {
//        donationMinuteInSeconds = self.donations[i].startTime + self.donations[i].timeLimit;
//        timeTillExpire = timeInSeconds - donationMinuteInSeconds;
//        self.donations[i][@"timeTillExpire"] = [NSNumber numberWithDouble:timeTillExpire];
//    }
//
//    NSSortDescriptor *sortDescriptor;
//    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeTillExpire" ascending:YES];
//    self.donations = [self.donations sortedArrayUsingDescriptors:@[sortDescriptor]];
    
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
