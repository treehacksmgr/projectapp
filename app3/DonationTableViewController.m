//
//  DonationTableViewController.m
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "DonationTableViewController.h"
#import "DonationCell.h"


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
    [self queryForDonations];
    self.donations = [NSArray arrayWithArray:self.donationsMutable];
    self.tableView.dataSource = self;
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DonationCell"];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];

    location2.latitude = locationManager.location.coordinate.latitude;
    location2.longitude = locationManager.location.coordinate.longitude;
    
    NSLog(@"help");
}


-(void)queryForDonations{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    FIRDatabaseReference *rootRef= [[FIRDatabase database] reference];
    [rootRef observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot)
     {
         dispatch_semaphore_signal(sema);
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
                     //NSLog(@"%@", key1);
                     NSDictionary *smallerDict = smallDict[key1];
                     newDonor.foodType = smallerDict[@"fType"];
                     NSString *longitudeString = smallerDict[@"long"];
                     newDonor.longitude = [NSNumber numberWithDouble:[longitudeString doubleValue]];
                     NSString *latitudeString = smallerDict[@"lat"];
                     newDonor.latitude = [NSNumber numberWithDouble:[latitudeString doubleValue]];
                     NSString *quantString = smallerDict[@"quant"];
                     newDonor.quantity = [NSNumber numberWithDouble:[quantString doubleValue]];
                     NSString *nameString = [help objectForKey:key][@"name"];
                     newDonor.orgName = nameString;
                     //NSLog(@"here");
                     [self.donationsMutable addObject:newDonor];
                 }
                 
                // NSLog(@"here2");
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
         //self.donations = [NSArray arrayWithArray:self.donationsMutable];
     }];
    //NSLog(@"testing query");
    //FIRDataEventTypeValue *refhandle;
    while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) { [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];}
    dispatch_release(sema);
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //DonationCell *cell = [[DonationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    DonationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DonationCell" forIndexPath:indexPath];
    Donation *returnedDonation = self.donations[indexPath.row];
    cell.donationTitle.text = returnedDonation.orgName;
    cell.foodLabel.text = returnedDonation.foodType;
    //cell.delegate = self;
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
