//
//  Giver.m
//  app3
//
//  Created by Mark Scarsi on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//
#import <Firebase/Firebase.h>
//#import "FIRDatabase.h"
//#import "FIRDatabaseReference.h"
#import "Giver.h"
@import Firebase;
@implementation Giver


- (IBAction)user_name:(id)sender {
  FIRFirestore * apple;
  FIRDatabaseReference *reference;
  FIRCollectionReference *citiesRef = [apple collectionWithPath:@"users"];
}

@end
