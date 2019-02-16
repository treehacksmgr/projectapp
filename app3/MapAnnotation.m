//
//  MapAnnotation.m
//  app3
//
//  Created by Ginger Dudley on 2/16/19.
//  Copyright © 2019 Ginger Dudley. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation

-(id)initWithTitle:(NSString *)title andCoordinate:
(CLLocationCoordinate2D)coordinate2d {
    
    self.title = title;
    self.coordinate =coordinate2d;
    return self;
}

-(MKMarkerAnnotationView *)annotationView{
    MKMarkerAnnotationView *annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"CustomMapAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annotationView;
}

@end
