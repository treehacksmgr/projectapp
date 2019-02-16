//
//  ViewController.m
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "ViewController.h"
#import <Firebase/Firebase.h>
#import "MapAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import "PopOverViewController.h"

@interface ViewController ()

@end

@implementation ViewController{

    CLLocationManager *locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [locationManager startUpdatingLocation];
        NSLog(@"Location services are enabled");
    } else {
        NSLog(@"Location services are not enabled");
    }
    
    //locationManager = [[CLLocationManager alloc] init];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    //self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(37.32, -122.03);
    self.mapView.mapType = MKMapTypeHybrid;
    //CLLocationCoordinate2D location;

    CLLocationCoordinate2D location2;

    location2.latitude = locationManager.location.coordinate.latitude;
    location2.longitude = locationManager.location.coordinate.longitude;
    MapAnnotation *newAnnotation2 = [[MapAnnotation alloc]
                                     initWithTitle:@"ugh" andCoordinate:location2];
    [self.mapView addAnnotation:newAnnotation2];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.userButton];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MapAnnotation *myLocation = (MapAnnotation *) annotation;
    MKAnnotationView *annotationView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomMapAnnotation"];
    if (annotationView == nil) {
        annotationView = myLocation.annotationView;
    } else{
        annotationView.annotation = annotation;
    }
   
    return annotationView;
}

// When a map annotation point is added, zoom to it (1500 range)
//proabbly delete this
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id <MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance
    ([mp coordinate], 1500, 1500);
    [mv setRegion:region animated:YES];
    //[mv selectAnnotation:mp animated:YES];
}

- (void)mapView:(MKMapView *)mapView
didSelectAnnotationView:(MKAnnotationView *)view{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"PopOver"];
    //PopOverViewController *newPopover = [[PopOverViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
